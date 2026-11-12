import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/error/result.dart';
import 'package:quran_app/core/platform/clock.dart';
import 'package:quran_app/core/platform/fixed_notification_center.dart';
import 'package:quran_app/features/home/domain/calculation.dart';
import 'package:quran_app/features/home/domain/location.dart';
import 'package:quran_app/features/home/domain/prayer_math.dart';
import 'package:quran_app/features/home/domain/repositories/location_repository.dart';
import 'package:quran_app/features/home/domain/repositories/prayer_times_calculator.dart';
import 'package:quran_app/features/prayer_alerts/domain/alert_settings.dart';
import 'package:quran_app/features/prayer_alerts/domain/plan_alerts.dart';
import 'package:quran_app/features/prayer_alerts/domain/usecases/reschedule_alerts.dart';
import 'package:quran_app/features/prayer_alerts/domain/voice_catalog.dart';

class _Location implements LocationRepository {
  @override
  Future<Result<LocationSnapshot>> resolve() async => const Ok(
    LocationSnapshot(
      location: UserLocation(
        latitude: 21.42,
        longitude: 39.82,
        source: LocationSource.gps,
        timeZoneId: 'Asia/Riyadh',
        countryCode: 'SA',
      ),
      permission: LocationPermissionStatus.granted,
    ),
  );

  @override
  Future<Result<LocationSnapshot>> requestPermission() => resolve();

  @override
  Future<Result<bool>> openAppSettings() async => const Ok(true);

  @override
  Future<Result<bool>> openLocationSettings() async => const Ok(true);
}

class _Calculator implements PrayerTimesCalculator {
  @override
  DayTimes calculate({
    required double latitude,
    required double longitude,
    required DateTime civilDate,
    required Duration utcOffset,
    required CalculationMethodId method,
    required AsrMethod asr,
    required bool ramadan,
  }) {
    return DayTimes(
      fajr: parseClock('04:22'),
      sunrise: parseClock('05:39'),
      dhuhr: parseClock('11:30'),
      asr: parseClock('14:50'),
      maghrib: parseClock('17:22'),
      isha: parseClock('18:35'),
    );
  }
}

void main() {
  test(
    'reschedule replaces the pending set and clears it when paused',
    () async {
      final center = FixedNotificationCenter();
      final useCase = RescheduleAlerts(
        calculator: _Calculator(),
        location: _Location(),
        scheduler: center,
        clock: FixedClock(DateTime(2026, 10, 27, 10)),
      );
      final planned = await useCase.call(
        settings: const PrayerAlertSettings(voice: AdhanVoice.madinah),
        methodOverride: null,
        asr: AsrMethod.standard,
        hijriAdjustment: 0,
        osGranted: true,
        text: (alert) => AlertText(
          title: alert.kind.name,
          body: alert.channelId,
          channelName: 'Prayer alerts',
        ),
      );
      expect(planned, isNotEmpty);
      expect(center.last, hasLength(planned.length));
      expect(
        center.last
            .map((item) => item.when)
            .every((when) => when.isAfter(DateTime(2026, 10, 27, 10))),
        isTrue,
      );
      expect(
        center.last.any(
          (item) =>
              item.channelId == AdhanVoiceCatalog.channelId(AdhanVoice.madinah),
        ),
        isTrue,
      );
      expect(center.last.first.title, isNotEmpty);

      await useCase.call(
        settings: const PrayerAlertSettings(promptsPaused: true),
        methodOverride: null,
        asr: AsrMethod.standard,
        hijriAdjustment: 0,
        osGranted: true,
        text: (_) => const AlertText(title: 'x', body: 'y', channelName: 'z'),
      );
      expect(center.last, isEmpty);
    },
  );
}
