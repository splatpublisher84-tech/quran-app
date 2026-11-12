import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/app.dart';
import 'package:quran_app/app/config/app_config.dart';
import 'package:quran_app/app/config/app_flavor.dart';
import 'package:quran_app/core/di/infrastructure_providers.dart';
import 'package:quran_app/core/storage/app_database.dart';
import 'package:quran_app/core/storage/app_preferences.dart';
import 'package:quran_app/features/home/di/prayer_providers.dart';
import 'package:quran_app/features/prayer_alerts/di/alert_providers.dart';
import 'package:quran_app/features/quran/di/quran_providers.dart';
import 'package:quran_app/shared/widgets/shared_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpApp(WidgetTester tester, {required bool onboarded}) async {
  SharedPreferences.setMockInitialValues({
    AppPreferences.onboardingKey: onboarded,
    AppPreferences.quranLanguageKey: 'en',
  });
  final prefs = await SharedPreferences.getInstance();
  final database = AppDatabase(NativeDatabase.memory());
  addTearDown(database.close);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(AppConfig.forFlavor(AppFlavor.dev)),
        sharedPreferencesProvider.overrideWithValue(prefs),
        ...quranFeatureOverrides(),
        ...prayerFeatureOverrides(),
        ...alertFeatureOverrides(),
        appDatabaseProvider.overrideWithValue(database),
      ],
      child: const QuranApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('onboarded user lands on Home with four tabs', (tester) async {
    await _pumpApp(tester, onboarded: true);

    expect(find.byType(AppTabBar), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Quran'), findsOneWidget);
    expect(find.text('Ayah of the day'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('tapping a tab switches the branch', (tester) async {
    await _pumpApp(tester, onboarded: true);

    await tester.tap(find.text('Quran'));
    await tester.pumpAndSettle();

    expect(find.text('Al-Faatiha'), findsOneWidget);
    expect(find.text('Surah'), findsWidgets);
    expect(find.byType(AppNavBar), findsNothing);
  });

  testWidgets('new user is redirected to onboarding', (tester) async {
    await _pumpApp(tester, onboarded: false);

    expect(find.byType(AppTabBar), findsNothing);
    expect(find.text('Get started'), findsOneWidget);
    expect(
      find.text('Quiet by design. No ads during prayer or reading.'),
      findsOneWidget,
    );
    expect(find.text('Choose a city instead'), findsNothing);
  });

  testWidgets('finishing onboarding opens Home and stays there', (
    tester,
  ) async {
    await _pumpApp(tester, onboarded: false);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    expect(find.text('Use my location'), findsOneWidget);
    expect(find.text('Choose a city instead'), findsNothing);

    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();
    expect(find.text('Turn on prayer alerts'), findsOneWidget);

    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();

    expect(find.byType(AppTabBar), findsOneWidget);
    expect(find.text('Get started'), findsNothing);
    expect(find.text('Prayer alerts are off'), findsOneWidget);
  });
}
