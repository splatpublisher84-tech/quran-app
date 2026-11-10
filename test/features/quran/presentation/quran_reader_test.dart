import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/app.dart';
import 'package:quran_app/app/config/app_config.dart';
import 'package:quran_app/app/config/app_flavor.dart';
import 'package:quran_app/core/di/infrastructure_providers.dart';
import 'package:quran_app/core/storage/app_database.dart';
import 'package:quran_app/core/storage/app_preferences.dart';
import 'package:quran_app/features/quran/di/quran_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('search opens an ayah, save keeps it on the Saved list', (
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
            AppConfig.forFlavor(AppFlavor.dev),
          ),
          sharedPreferencesProvider.overrideWithValue(prefs),
          ...quranFeatureOverrides(),
          appDatabaseProvider.overrideWithValue(database),
        ],
        child: const QuranApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Quran'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '112:1');
    await tester.pump();
    await tester.tap(find.text('Go to 112:1'));
    await tester.pumpAndSettle();

    expect(find.textContaining('He is Allāh'), findsWidgets);
    await tester.tap(find.textContaining('He is Allāh').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Saved'), findsWidgets);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    expect(find.text('112:1'), findsWidgets);
    expect(find.textContaining('He is Allāh'), findsOneWidget);
  });
}
