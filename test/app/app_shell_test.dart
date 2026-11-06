import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/app.dart';
import 'package:quran_app/app/config/app_config.dart';
import 'package:quran_app/app/config/app_flavor.dart';
import 'package:quran_app/core/di/infrastructure_providers.dart';
import 'package:quran_app/core/storage/app_preferences.dart';
import 'package:quran_app/shared/widgets/shared_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpApp(WidgetTester tester, {required bool onboarded}) async {
  SharedPreferences.setMockInitialValues({
    AppPreferences.onboardingKey: onboarded,
  });
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(AppConfig.forFlavor(AppFlavor.dev)),
        sharedPreferencesProvider.overrideWithValue(prefs),
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

    expect(
      find.text('This screen arrives in a later milestone.'),
      findsOneWidget,
    );
    expect(find.byType(AppNavBar), findsOneWidget);
  });

  testWidgets('new user is redirected to onboarding', (tester) async {
    await _pumpApp(tester, onboarded: false);

    expect(find.byType(AppTabBar), findsNothing);
    expect(find.text('Get started'), findsOneWidget);
  });

  testWidgets('finishing onboarding opens Home and stays there', (
    tester,
  ) async {
    await _pumpApp(tester, onboarded: false);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.byType(AppTabBar), findsOneWidget);
    expect(find.text('Get started'), findsNothing);
  });
}
