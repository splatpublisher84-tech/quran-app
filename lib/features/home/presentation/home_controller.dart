import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/infrastructure_providers.dart';
import '../../../core/di/notification_providers.dart';
import '../../../core/platform/notification_types.dart';
import '../../../core/platform/permission_service.dart';
import '../../../core/storage/app_preferences.dart';
import '../domain/calculation.dart';
import '../domain/hijri_calendar.dart';
import '../domain/home_day.dart';
import '../domain/location.dart';
import '../domain/prayer_math.dart';
import 'prayer_providers.dart';

class _Inputs {
  const _Inputs({
    required this.now,
    required this.times,
    required this.hijri,
    required this.paused,
    required this.locationEstimated,
    required this.locationAction,
    required this.preview,
    required this.dayKey,
    required this.notificationsOff,
  });

  final DateTime now;
  final DayTimes times;
  final HijriDate hijri;
  final bool paused;
  final bool locationEstimated;
  final LocationPromptAction locationAction;
  final HomePreview preview;
  final String dayKey;
  final bool notificationsOff;
}

class HomeController extends AsyncNotifier<HomeView> {
  _Inputs? _inputs;

  @override
  Future<HomeView> build() async {
    final snapshot = await ref.watch(locationSnapshotProvider.future);
    final settings = ref.watch(prayerSettingsProvider);
    final alerts = ref.watch(displayedAlertSettingsProvider);
    final access = await ref.watch(notificationAccessProvider.future);
    final config = ref.watch(appConfigProvider);
    final debug = ref.watch(debugSessionProvider);
    final deviceNow = ref.watch(clockProvider).now();
    final useDebug = config.isDev && debug.clock != null;
    final now = useDebug ? debug.clock! : deviceNow;
    final preview = config.isDev ? debug.preview : HomePreview.live;
    final method =
        settings.methodOverride ??
        methodForCountry(snapshot.location.countryCode);
    final calculator = ref.watch(prayerTimesCalculatorProvider);

    var times = calculator.calculate(
      latitude: snapshot.location.latitude,
      longitude: snapshot.location.longitude,
      civilDate: now,
      utcOffset: now.timeZoneOffset,
      method: method,
      asr: settings.asr,
      ramadan: false,
    );
    final hijri = displayedHijri(
      civil: now,
      minuteOfDay: minuteOfDay(now),
      maghribMinute: times.maghrib,
      adjustment: settings.clampedAdjustment,
    );
    final ramadan = hijri.isRamadan || preview == HomePreview.ramadan;
    if (ramadan && method == CalculationMethodId.ummAlQura) {
      times = calculator.calculate(
        latitude: snapshot.location.latitude,
        longitude: snapshot.location.longitude,
        civilDate: now,
        utcOffset: now.timeZoneOffset,
        method: method,
        asr: settings.asr,
        ramadan: true,
      );
    }
    if (ramadan) times = times.withImsak();

    final dayKey = prayerDayKey(now, times.fajr);
    final prayed = _readPrayed(dayKey);
    final estimated = snapshot.location.source == LocationSource.timezone;
    final inputs = _Inputs(
      now: now,
      times: times,
      hijri: hijri,
      paused: settings.promptsPaused,
      locationEstimated: estimated,
      locationAction: promptFor(snapshot.permission),
      preview: preview,
      dayKey: dayKey,
      notificationsOff:
          !alerts.enabled || access != NotificationPermissionStatus.granted,
    );
    _inputs = inputs;
    _scheduleTick(now, frozen: useDebug);
    return _view(inputs, prayed);
  }

  Future<Set<PrayerId>?> markPrayed() async {
    final inputs = _inputs;
    final current = state.value;
    final id = current?.markable;
    if (inputs == null || current == null || id == null) return null;
    final previous = Set<PrayerId>.of(current.prayed);
    final updated = {...previous, id};
    await _write(current.dayKey, updated);
    if (!ref.mounted) return previous;
    state = AsyncData(_view(inputs, updated));
    return previous;
  }

  Future<void> restorePrayed(Set<PrayerId> ids) async {
    final inputs = _inputs;
    final current = state.value;
    if (inputs == null || current == null) return;
    await _write(current.dayKey, ids);
    if (!ref.mounted) return;
    state = AsyncData(_view(inputs, ids));
  }

  Future<void> turnOnLocation() async {
    final action = state.value?.locationAction;
    if (action == null) return;
    final repository = ref.read(locationRepositoryProvider);
    switch (action) {
      case LocationPromptAction.requestPermission:
        await repository.requestPermission();
      case LocationPromptAction.openAppSettings:
        await repository.openAppSettings();
      case LocationPromptAction.openLocationSettings:
        await repository.openLocationSettings();
    }
    if (!ref.mounted) return;
    ref.invalidate(locationSnapshotProvider);
  }

  Future<void> turnOnNotifications() async {
    final before = await ref.read(notificationAccessProvider.future);
    await ref.read(appPreferencesProvider).setAlertsEnabled(true);
    if (!ref.mounted) return;
    await turnOnNotificationPermission(
      current: before,
      permissions: ref.read(permissionServiceProvider),
    );
    if (!ref.mounted) return;
    ref.invalidate(notificationAccessProvider);
    ref.read(preferenceRevisionProvider.notifier).bump();
  }

  void refreshLocation() {
    ref.invalidate(locationSnapshotProvider);
  }

  HomeView _view(_Inputs inputs, Set<PrayerId> prayed) {
    return buildHomeView(
      now: inputs.now,
      times: inputs.times,
      hijri: inputs.hijri,
      prayed: prayed,
      paused: inputs.paused,
      locationEstimated: inputs.locationEstimated,
      locationAction: inputs.locationAction,
      notificationsOff: inputs.notificationsOff,
      preview: inputs.preview,
      dayKey: inputs.dayKey,
    );
  }

  Set<PrayerId> _readPrayed(String dayKey) {
    final prefs = ref.read(appPreferencesProvider);
    if (prefs.prayedDay != dayKey || prefs.prayedIds == null) return {};
    final ids = <PrayerId>{};
    for (final part in prefs.prayedIds!.split(',')) {
      for (final id in PrayerId.values) {
        if (id.name == part) ids.add(id);
      }
    }
    return ids;
  }

  Future<void> _write(String dayKey, Set<PrayerId> ids) {
    final names = ids.map((id) => id.name).toList()..sort();
    return ref
        .read(appPreferencesProvider)
        .setPrayed(day: dayKey, ids: names.join(','));
  }

  void _scheduleTick(DateTime now, {required bool frozen}) {
    if (frozen) return;
    // A fixed test clock can sit far from the real minute. Ticking it would
    // reschedule forever and hang pumpAndSettle.
    if (now.difference(DateTime.now()).abs() > const Duration(minutes: 1)) {
      return;
    }
    final nextMinute = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute + 1,
    );
    var delay = nextMinute.difference(DateTime.now());
    if (delay < const Duration(seconds: 1)) {
      delay = const Duration(minutes: 1);
    }
    final timer = Timer(delay, () {
      if (ref.mounted) ref.invalidateSelf();
    });
    ref.onDispose(timer.cancel);
  }
}

final homeProvider = AsyncNotifierProvider<HomeController, HomeView>(
  HomeController.new,
);
