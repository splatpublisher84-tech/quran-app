import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/app.dart';
import 'package:quran_app/app/config/app_config.dart';
import 'package:quran_app/app/config/app_flavor.dart';
import 'package:quran_app/core/di/infrastructure_providers.dart';
import 'package:quran_app/core/platform/clock.dart';
import 'package:quran_app/core/storage/app_database.dart';
import 'package:quran_app/core/storage/app_preferences.dart';
import 'package:quran_app/features/home/di/prayer_providers.dart';
import 'package:quran_app/features/home/domain/calculation.dart';
import 'package:quran_app/features/home/domain/prayer_math.dart';
import 'package:quran_app/features/home/domain/repositories/prayer_times_calculator.dart';
import 'package:quran_app/features/prayer_alerts/di/alert_providers.dart';
import 'package:quran_app/features/quran/di/quran_providers.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FixedCalculator implements PrayerTimesCalculator {
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
      imsak: ramadan ? parseClock('04:12') : null,
    );
  }
}

void main() {
  testWidgets('Home shows the now banner and can undo a prayer mark', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      AppPreferences.onboardingKey: true,
      AppPreferences.quranLanguageKey: 'en',
    });
    final prefs = await SharedPreferences.getInstance();
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            AppConfig.forFlavor(AppFlavor.prod),
          ),
          sharedPreferencesProvider.overrideWithValue(prefs),
          clockProvider.overrideWithValue(
            FixedClock(DateTime(2026, 10, 27, 14, 58)),
          ),
          ...prayerFeatureOverrides(calculator: _FixedCalculator()),
          ...quranFeatureOverrides(),
          ...alertFeatureOverrides(),
          appDatabaseProvider.overrideWithValue(database),
        ],
        child: const QuranApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("IT'S TIME"), findsOneWidget);
    expect(find.text('Asr'), findsWidgets);
    expect(
      find.text('Times are estimated from your time zone.'),
      findsOneWidget,
    );

    await tester.tap(find.text("I've prayed"));
    await tester.pumpAndSettle();
    expect(find.text('Asr marked as prayed'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text("IT'S TIME"), findsOneWidget);
  });
}
