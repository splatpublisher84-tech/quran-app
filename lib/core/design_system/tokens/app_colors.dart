import 'package:flutter/material.dart';

/// Semantic color tokens. Widgets read these through `context.colors`,
/// never raw hex values.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brand,
    required this.onBrand,
    required this.accent,
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.glass,
    required this.danger,
  });

  /// Light theme (default).
  static const light = AppColors(
    brand: Color(0xFF1F5E4E),
    onBrand: Color(0xFFFFFFFF),
    accent: Color(0xFF8A6128),
    background: Color(0xFFFBF9F4),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF3EFE6),
    textPrimary: Color(0xFF1B1A17),
    textSecondary: Color(0xFF5E5A52),
    border: Color(0xFFE4DED1),
    glass: Color(0x99FFFFFF),
    danger: Color(0xFFB3261E),
  );

  static const dark = AppColors(
    brand: Color(0xFF8CC7B3),
    onBrand: Color(0xFF0F1F1A),
    accent: Color(0xFFD8B26A),
    background: Color(0xFF15120D),
    surface: Color(0xFF1E1B15),
    surfaceMuted: Color(0xFF27231B),
    textPrimary: Color(0xFFF4EFE4),
    textSecondary: Color(0xFFB9B2A3),
    border: Color(0xFF3A342A),
    glass: Color(0x991E1B15),
    danger: Color(0xFFF2B8B5),
  );

  final Color brand;
  final Color onBrand;
  final Color accent;
  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color glass;
  final Color danger;

  @override
  AppColors copyWith({
    Color? brand,
    Color? onBrand,
    Color? accent,
    Color? background,
    Color? surface,
    Color? surfaceMuted,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? glass,
    Color? danger,
  }) {
    return AppColors(
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      accent: accent ?? this.accent,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      glass: glass ?? this.glass,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      brand: Color.lerp(brand, other.brand, t)!,
      onBrand: Color.lerp(onBrand, other.onBrand, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}
