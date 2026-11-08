import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_text_styles.dart';

/// Builds the light and dark `ThemeData`. Light is the default.
abstract final class AppTheme {
  static ThemeData light() => _build(AppColors.light, Brightness.light);

  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors c, Brightness brightness) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: c.brandDefault,
          brightness: brightness,
        ).copyWith(
          primary: c.buttonPrimary,
          onPrimary: c.textInverse,
          secondary: c.accentDefault,
          surface: c.backgroundDefault,
          onSurface: c.textPrimary,
          error: c.statusError,
          outline: c.borderDefault,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.backgroundSurface,
      fontFamily: AppTextStyles.uiFamily,
      dividerColor: c.borderSubtle,
      extensions: [c],
      appBarTheme: AppBarTheme(
        backgroundColor: c.backgroundSurface,
        foregroundColor: c.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.uiHeadingSmall.copyWith(
          color: c.textPrimary,
        ),
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
