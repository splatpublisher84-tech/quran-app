import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'notification_types.dart';

bool get _underTest => Platform.environment.containsKey('FLUTTER_TEST');

/// Local notifications for salah, daily ayahs, suhoor, iftar and Jumu'ah.
///
/// v1 adhan pre-mortem (Q-07), as locked in the plan: the sound is at most
/// five seconds and is shared by iOS and Android. Scheduling is inexact
/// (no exact alarm, no foreground service, no reschedule on boot). The set
/// is replaced whenever the app opens or the inputs change. A missing clip
/// uses the system default sound.
final class LocalNotificationCenter implements LocalNotifications {
  FlutterLocalNotificationsPlugin? _plugin;
  var _ready = false;

  FlutterLocalNotificationsPlugin get _notifications =>
      _plugin ??= FlutterLocalNotificationsPlugin();

  @override
  Future<NotificationPermissionStatus> status() async {
    if (_underTest) return NotificationPermissionStatus.granted;
    await _ensureReady();
    if (defaultTargetPlatform == TargetPlatform.android) {
      final enabled = await _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.areNotificationsEnabled();
      return _fromBool(enabled);
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final options = await _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.checkPermissions();
      return _fromBool(options?.isEnabled);
    }
    return NotificationPermissionStatus.granted;
  }

  @override
  Future<NotificationPermissionStatus> request() async {
    if (_underTest) return NotificationPermissionStatus.granted;
    await _ensureReady();
    if (defaultTargetPlatform == TargetPlatform.android) {
      final granted = await _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return _fromBool(granted);
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final granted = await _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, sound: true);
      return _fromBool(granted);
    }
    return NotificationPermissionStatus.granted;
  }

  @override
  Future<void> replaceAll(List<PendingNotification> pending) async {
    if (_underTest) return;
    await _ensureReady();
    await _notifications.cancelAll();
    final now = tz.TZDateTime.now(tz.local);
    for (final item in pending) {
      final when = _zoned(item.when);
      if (!when.isAfter(now)) continue;
      final details = NotificationDetails(
        android: AndroidNotificationDetails(
          item.channelId,
          item.channelName,
          importance: Importance.high,
          priority: Priority.high,
          sound: item.soundResource == null
              ? null
              : RawResourceAndroidNotificationSound(item.soundResource),
        ),
        iOS: DarwinNotificationDetails(sound: item.soundResource),
      );
      try {
        await _notifications.zonedSchedule(
          id: item.id,
          title: item.title,
          body: item.body,
          scheduledDate: when,
          notificationDetails: details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      } on Object {
        // One rejected time must not drop the rest of the window.
      }
    }
  }

  Future<void> _ensureReady() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } on Object {
      tz.setLocalLocation(tz.UTC);
    }
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _notifications.initialize(settings: settings);
    _ready = true;
  }

  tz.TZDateTime _zoned(DateTime when) {
    if (tz.local.name == 'UTC') return tz.TZDateTime.from(when.toUtc(), tz.UTC);
    return tz.TZDateTime.from(when, tz.local);
  }

  NotificationPermissionStatus _fromBool(bool? granted) {
    if (granted == null) return NotificationPermissionStatus.unknown;
    return granted
        ? NotificationPermissionStatus.granted
        : NotificationPermissionStatus.denied;
  }
}
