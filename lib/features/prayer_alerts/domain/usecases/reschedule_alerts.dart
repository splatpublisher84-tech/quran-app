import '../../../../core/platform/clock.dart';
import '../../../../core/platform/notification_types.dart';
import '../../../home/domain/calculation.dart';
import '../../../home/domain/hijri_calendar.dart';
import '../../../home/domain/repositories/location_repository.dart';
import '../../../home/domain/repositories/prayer_times_calculator.dart';
import '../alert_settings.dart';
import '../plan_alerts.dart';

/// Rebuilds the sliding notification window from location, calculation and
/// alert settings, then asks the scheduler to replace what is pending.
class RescheduleAlerts {
  const RescheduleAlerts({
    required this._calculator,
    required this._location,
    required this._scheduler,
    required this._clock,
  });

  final PrayerTimesCalculator _calculator;
  final LocationRepository _location;
  final NotificationScheduler _scheduler;
  final AppClock _clock;

  Future<List<PlannedAlert>> call({
    required PrayerAlertSettings settings,
    required CalculationMethodId? methodOverride,
    required AsrMethod asr,
    required int hijriAdjustment,
    required bool osGranted,
    required AlertText Function(PlannedAlert alert) text,
  }) async {
    final result = await _location.resolve();
    final snapshot = result.valueOrNull;
    if (snapshot == null) {
      await _scheduler.replaceAll(const []);
      return const [];
    }
    final now = _clock.now();
    final method =
        methodOverride ?? methodForCountry(snapshot.location.countryCode);
    final days = <AlertDay>[
      for (var i = 0; i < scheduleWindowDays; i++)
        _day(
          date: DateTime(now.year, now.month, now.day + i),
          method: method,
          asr: asr,
          adjustment: hijriAdjustment,
          latitude: snapshot.location.latitude,
          longitude: snapshot.location.longitude,
          offset: now.timeZoneOffset,
        ),
    ];
    final planned = planAlerts(
      now: now,
      days: days,
      settings: settings,
      notificationsGranted: osGranted,
    );
    final pending = <PendingNotification>[
      for (final alert in planned) _pending(alert, text(alert)),
    ];
    await _scheduler.replaceAll(pending);
    return planned;
  }

  AlertDay _day({
    required DateTime date,
    required CalculationMethodId method,
    required AsrMethod asr,
    required int adjustment,
    required double latitude,
    required double longitude,
    required Duration offset,
  }) {
    var times = _calculator.calculate(
      latitude: latitude,
      longitude: longitude,
      civilDate: date,
      utcOffset: offset,
      method: method,
      asr: asr,
      ramadan: false,
    );
    final hijri = displayedHijri(
      civil: date,
      minuteOfDay: times.dhuhr,
      maghribMinute: times.maghrib,
      adjustment: adjustment,
    );
    final ramadan = hijri.isRamadan;
    if (ramadan && method == CalculationMethodId.ummAlQura) {
      times = _calculator.calculate(
        latitude: latitude,
        longitude: longitude,
        civilDate: date,
        utcOffset: offset,
        method: method,
        asr: asr,
        ramadan: true,
      );
    }
    if (ramadan) times = times.withImsak();
    return AlertDay(date: date, times: times, ramadan: ramadan);
  }

  PendingNotification _pending(PlannedAlert alert, AlertText copy) {
    return PendingNotification(
      id: alert.id,
      title: copy.title,
      body: copy.body,
      when: alert.when,
      channelId: alert.channelId,
      channelName: copy.channelName,
      soundResource: alert.soundResource,
    );
  }
}
