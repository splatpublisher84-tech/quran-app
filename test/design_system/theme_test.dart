import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/design_system/design_system.dart';

void main() {
  test('light theme is the brightness and carries light tokens', () {
    final theme = AppTheme.light();
    expect(theme.brightness, Brightness.light);
    expect(theme.extension<AppColors>(), AppColors.light);
    expect(theme.scaffoldBackgroundColor, AppColors.light.backgroundSurface);
  });

  test('dark theme carries dark tokens', () {
    final theme = AppTheme.dark();
    expect(theme.brightness, Brightness.dark);
    expect(theme.extension<AppColors>(), AppColors.dark);
  });

  test('AppColors.lerp moves between light and dark', () {
    final mid = AppColors.light.lerp(AppColors.dark, 0.5);
    expect(mid.backgroundSurface, isNot(AppColors.light.backgroundSurface));
    expect(mid.backgroundSurface, isNot(AppColors.dark.backgroundSurface));
    expect(
      AppColors.light.lerp(AppColors.dark, 0).backgroundSurface,
      AppColors.light.backgroundSurface,
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
