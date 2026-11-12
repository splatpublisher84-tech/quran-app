import '../../home/domain/prayer_math.dart';
import 'alert_settings.dart';
import 'voice_catalog.dart';

/// How many civil days to schedule ahead. iOS keeps about 64 pending
/// notifications; [maxPendingAlerts] stays under that.
const int scheduleWindowDays = 7;

const int maxPendingAlerts = 60;

/// Jumu'ah reminder lead, when the option is on.
const int jumuahLeadMin = 30;

/// Daily ayah reminder, after Fajr or after Maghrib.
const int dailyAyahDelayMin = 15;

enum AlertKind { salah, dailyAyah, suhoor, iftar, jumuah }

/// One prayer day's times, already resolved for Ramadan.
class AlertDay {
  const AlertDay({
    required this.date,
    required this.times,
    required this.ramadan,
  });

  /// Local civil date. The time of day is ignored.
  final DateTime date;
  final DayTimes times;
  final bool ramadan;
}

class PlannedAlert {
  const PlannedAlert({
    required this.id,
    required this.kind,
    required this.when,
    required this.channelId,
    required this.mode,
    this.prayer,
    this.voice,
    this.soundResource,
  });

  final int id;
  final AlertKind kind;
  final DateTime when;
  final String channelId;
  final AlertMode mode;
  final PrayerId? prayer;
  final AdhanVoice? voice;
  final String? soundResource;
}

class AlertText {
  const AlertText({
    required this.title,
    required this.body,
    required this.channelName,
  });

  final String title;
  final String body;
  final String channelName;
}

/// The pending set for the current settings. Empty when alerts are off,
/// paused, or the system has not granted notification permission.
List<PlannedAlert> planAlerts({
  required DateTime now,
  required List<AlertDay> days,
  required PrayerAlertSettings settings,
  required bool notificationsGranted,
  int maxPending = maxPendingAlerts,
  bool soundsBundled = AdhanVoiceCatalog.soundsBundled,
}) {
  if (!notificationsGranted || !settings.enabled || settings.promptsPaused) {
    return const [];
  }
  final planned = <PlannedAlert>[];
  for (var dayIndex = 0; dayIndex < days.length; dayIndex++) {
    final day = days[dayIndex];
    for (final id in prayers) {
      final mode = settings.modeOf(id);
      if (mode == AlertMode.off) continue;
      _add(
        planned,
        now: now,
        when: _at(day.date, day.times.minutesOf(id) + settings.offsetOf(id)),
        alert: PlannedAlert(
          id: dayIndex * 10 + id.index,
          kind: AlertKind.salah,
          when: _at(day.date, day.times.minutesOf(id) + settings.offsetOf(id)),
          channelId: AdhanVoiceCatalog.channelFor(
            mode: mode,
            voice: settings.voice,
          ),
          mode: mode,
          prayer: id,
          voice: mode == AlertMode.adhan ? settings.voice : null,
          soundResource: mode == AlertMode.adhan
              ? AdhanVoiceCatalog.soundResource(
                  settings.voice,
                  bundled: soundsBundled,
                )
              : null,
        ),
      );
    }
    if (settings.dailyAyahEnabled) {
      final anchor = settings.dailyAyahSlot == DailyAyahSlot.afterFajr
          ? day.times.fajr
          : day.times.maghrib;
      _add(
        planned,
        now: now,
        when: _at(day.date, anchor + dailyAyahDelayMin),
        alert: PlannedAlert(
          id: 1000 + dayIndex,
          kind: AlertKind.dailyAyah,
          when: _at(day.date, anchor + dailyAyahDelayMin),
          channelId: AdhanVoiceCatalog.dailyAyahChannelId,
          mode: AlertMode.notify,
        ),
      );
    }
    if (day.ramadan) {
      final imsak = day.times.imsak ?? day.times.fajr - imsakLeadMin;
      _add(
        planned,
        now: now,
        when: _at(day.date, imsak),
        alert: PlannedAlert(
          id: 2000 + dayIndex,
          kind: AlertKind.suhoor,
          when: _at(day.date, imsak),
          channelId: AdhanVoiceCatalog.suhoorChannelId,
          mode: AlertMode.notify,
        ),
      );
      _add(
        planned,
        now: now,
        when: _at(day.date, day.times.maghrib),
        alert: PlannedAlert(
          id: 3000 + dayIndex,
          kind: AlertKind.iftar,
          when: _at(day.date, day.times.maghrib),
          channelId: AdhanVoiceCatalog.iftarChannelId,
          mode: AlertMode.notify,
        ),
      );
    }
    if (settings.jumuahEarly && day.date.weekday == DateTime.friday) {
      _add(
        planned,
        now: now,
        when: _at(day.date, day.times.dhuhr - jumuahLeadMin),
        alert: PlannedAlert(
          id: 4000 + dayIndex,
          kind: AlertKind.jumuah,
          when: _at(day.date, day.times.dhuhr - jumuahLeadMin),
          channelId: AdhanVoiceCatalog.jumuahChannelId,
          mode: AlertMode.notify,
        ),
      );
    }
  }
  planned.sort((a, b) => a.when.compareTo(b.when));
  if (planned.length <= maxPending) return planned;
  return planned.sublist(0, maxPending);
}

void _add(
  List<PlannedAlert> planned, {
  required DateTime now,
  required DateTime when,
  required PlannedAlert alert,
}) {
  if (when.isAfter(now)) planned.add(alert);
}

DateTime _at(DateTime day, int minute) {
  return DateTime(day.year, day.month, day.day).add(Duration(minutes: minute));
}
