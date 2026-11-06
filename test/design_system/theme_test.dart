import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/design_system/design_system.dart';

void main() {
  test('light theme is the brightness and carries light tokens', () {
    final theme = AppTheme.light();
    expect(theme.brightness, Brightness.light);
    expect(theme.extension<AppColors>(), AppColors.light);
    expect(theme.scaffoldBackgroundColor, const Color(0xFFFBF9F4));
  });

  test('dark theme carries dark tokens', () {
    final theme = AppTheme.dark();
    expect(theme.brightness, Brightness.dark);
    expect(theme.extension<AppColors>(), AppColors.dark);
  });

  test('AppColors.lerp moves between light and dark', () {
    final mid = AppColors.light.lerp(AppColors.dark, 0.5);
    expect(mid.background, isNot(AppColors.light.background));
    expect(mid.background, isNot(AppColors.dark.background));
    expect(
      AppColors.light.lerp(AppColors.dark, 0).background,
      AppColors.light.background,
    );
  });

  testWidgets('context.colors resolves the active theme', (tester) async {
    late AppColors seen;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Builder(
          builder: (context) {
            seen = context.colors;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(seen, AppColors.dark);
  });
}
