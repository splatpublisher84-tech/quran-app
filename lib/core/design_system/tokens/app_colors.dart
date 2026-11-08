import 'package:flutter/material.dart';

/// Semantic color tokens, generated from `dev-handoff/01-design-tokens`
/// plus the prototype aliases (`--group-bg`, `--toast-bg`, `--card-gradient`...).
/// Widgets read these through `context.colors`, never raw hex values.
///
/// Naming follows the handoff: `background/default` is a card surface,
/// `background/surface` is the screen background.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.backgroundDefault,
    required this.backgroundSurface,
    required this.backgroundElevated,
    required this.backgroundOverlay,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInverse,
    required this.borderDefault,
    required this.borderSubtle,
    required this.buttonPrimary,
    required this.buttonPrimaryDisabled,
    required this.buttonPrimaryPressed,
    required this.buttonSecondary,
    required this.buttonSecondaryBorder,
    required this.buttonIcon,
    required this.buttonGlass,
    required this.buttonGlassBorder,
    required this.buttonInverse,
    required this.statusSuccess,
    required this.statusError,
    required this.statusWarning,
    required this.statusSuccessSurface,
    required this.statusErrorSurface,
    required this.statusWarningSurface,
    required this.inputBackground,
    required this.inputBorderDefault,
    required this.inputBorderFocus,
    required this.inputPlaceholder,
    required this.brandDefault,
    required this.brandSoft,
    required this.accentDefault,
    required this.groupBackground,
    required this.toastBackground,
    required this.dialogBackground,
    required this.segmentOn,
    required this.cardText,
    required this.cardAccent,
    required this.cardGradientStart,
    required this.cardGradientMid,
    required this.cardGradientEnd,
    required this.sharePattern,
    required this.shareNightStart,
    required this.shareNightEnd,
    required this.premiumGradientStart,
    required this.premiumGradientEnd,
    required this.dialogAction,
  });

  /// Light theme (default).
  static const light = AppColors(
    backgroundDefault: Color(0xFFFFFFFF),
    backgroundSurface: Color(0xFFFBF9F4),
    backgroundElevated: Color(0xFFF1EFEA),
    backgroundOverlay: Color(0xFF15120D),
    textPrimary: Color(0xFF15120D),
    textSecondary: Color(0xFF84827D),
    textTertiary: Color(0xFFB3B1AC),
    textDisabled: Color(0xFFCECBC6),
    textInverse: Color(0xFFFFFFFF),
    borderDefault: Color(0xFFE5E3DD),
    borderSubtle: Color(0xFFEDEDED),
    buttonPrimary: Color(0xFF1F5E4E),
    buttonPrimaryDisabled: Color(0xFFCECBC6),
    buttonPrimaryPressed: Color(0xFF184A3E),
    buttonSecondary: Color(0xFFF1EFEA),
    buttonSecondaryBorder: Color(0xFFE5E3DD),
    buttonIcon: Color(0xFF84827D),
    buttonGlass: Color(0x29FFFFFF),
    buttonGlassBorder: Color(0x47FFFFFF),
    buttonInverse: Color(0xFFFFFFFF),
    statusSuccess: Color(0xFF009951),
    statusError: Color(0xFFC00F0C),
    statusWarning: Color(0xFFE5A000),
    statusSuccessSurface: Color(0xFF009951),
    statusErrorSurface: Color(0xFFC00F0C),
    statusWarningSurface: Color(0xFFE5A000),
    inputBackground: Color(0xFFFFFFFF),
    inputBorderDefault: Color(0xFFE5E3DD),
    inputBorderFocus: Color(0xFF15120D),
    inputPlaceholder: Color(0xFFB3B1AC),
    brandDefault: Color(0xFF1F5E4E),
    brandSoft: Color(0xFFE1ECE6),
    accentDefault: Color(0xFF8A6128),
    groupBackground: Color(0xFFF1EFEA),
    toastBackground: Color(0xFFF1EFEA),
    dialogBackground: Color(0xF0F5F5F5),
    segmentOn: Color(0xFFFFFFFF),
    cardText: Color(0xFFFBF9F4),
    cardAccent: Color(0xFFD8B26A),
    cardGradientStart: Color(0xFF0F3B31),
    cardGradientMid: Color(0xFF1F5E4E),
    cardGradientEnd: Color(0xFF2C6F5C),
    sharePattern: Color(0xFF173A31),
    shareNightStart: Color(0xFF15120D),
    shareNightEnd: Color(0xFF2A3125),
    premiumGradientStart: Color(0xFFFCC852),
    premiumGradientEnd: Color(0xFFE5A000),
    dialogAction: Color(0xFF0A7AFF),
  );

  /// Dark theme. Same token names, values from the handoff dark column.
  static const dark = AppColors(
    backgroundDefault: Color(0xFF43403B),
    backgroundSurface: Color(0xFF15120D),
    backgroundElevated: Color(0xFF84827D),
    backgroundOverlay: Color(0xFF15120D),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFCECBC6),
    textTertiary: Color(0xFFB3B1AC),
    textDisabled: Color(0xFF84827D),
    textInverse: Color(0xFF15120D),
    borderDefault: Color(0xFF84827D),
    borderSubtle: Color(0xFF84827D),
    buttonPrimary: Color(0xFF6FB39B),
    buttonPrimaryDisabled: Color(0xFFB3B1AC),
    buttonPrimaryPressed: Color(0xFF8CC5B0),
    buttonSecondary: Color(0xFF84827D),
    buttonSecondaryBorder: Color(0xFF84827D),
    buttonIcon: Color(0xFFEDEDED),
    buttonGlass: Color(0x29FFFFFF),
    buttonGlassBorder: Color(0x47FFFFFF),
    buttonInverse: Color(0xFFFFFFFF),
    statusSuccess: Color(0xFF00C464),
    statusError: Color(0xFFFF4444),
    statusWarning: Color(0xFFFFB020),
    statusSuccessSurface: Color(0xFF00C464),
    statusErrorSurface: Color(0xFFFF4444),
    statusWarningSurface: Color(0xFFFFB020),
    inputBackground: Color(0xFF43403B),
    inputBorderDefault: Color(0xFF84827D),
    inputBorderFocus: Color(0xFFFFFFFF),
    inputPlaceholder: Color(0xFFB3B1AC),
    brandDefault: Color(0xFF6FB39B),
    brandSoft: Color(0xFF1E3A31),
    accentDefault: Color(0xFFD8B26A),
    groupBackground: Color(0xFF43403B),
    toastBackground: Color(0xFF43403B),
    dialogBackground: Color(0xEF34322E),
    segmentOn: Color(0xFF15120D),
    cardText: Color(0xFFFBF9F4),
    cardAccent: Color(0xFFD8B26A),
    cardGradientStart: Color(0xFF0F3B31),
    cardGradientMid: Color(0xFF1F5E4E),
    cardGradientEnd: Color(0xFF2C6F5C),
    sharePattern: Color(0xFF173A31),
    shareNightStart: Color(0xFF15120D),
    shareNightEnd: Color(0xFF2A3125),
    premiumGradientStart: Color(0xFFFCC852),
    premiumGradientEnd: Color(0xFFE5A000),
    dialogAction: Color(0xFF0A7AFF),
  );

  final Color backgroundDefault;
  final Color backgroundSurface;
  final Color backgroundElevated;
  final Color backgroundOverlay;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textInverse;
  final Color borderDefault;
  final Color borderSubtle;
  final Color buttonPrimary;
  final Color buttonPrimaryDisabled;
  final Color buttonPrimaryPressed;
  final Color buttonSecondary;
  final Color buttonSecondaryBorder;
  final Color buttonIcon;
  final Color buttonGlass;
  final Color buttonGlassBorder;
  final Color buttonInverse;
  final Color statusSuccess;
  final Color statusError;
  final Color statusWarning;
  final Color statusSuccessSurface;
  final Color statusErrorSurface;
  final Color statusWarningSurface;
  final Color inputBackground;
  final Color inputBorderDefault;
  final Color inputBorderFocus;
  final Color inputPlaceholder;
  final Color brandDefault;
  final Color brandSoft;
  final Color accentDefault;
  final Color groupBackground;
  final Color toastBackground;
  final Color dialogBackground;
  final Color segmentOn;
  final Color cardText;
  final Color cardAccent;
  final Color cardGradientStart;
  final Color cardGradientMid;
  final Color cardGradientEnd;
  final Color sharePattern;
  final Color shareNightStart;
  final Color shareNightEnd;
  final Color premiumGradientStart;
  final Color premiumGradientEnd;
  final Color dialogAction;

  /// Ayah and prayer cards: `--card-gradient` at 165 degrees.
  LinearGradient get cardGradient => LinearGradient(
    begin: const Alignment(-0.42, -0.9),
    end: const Alignment(0.42, 0.9),
    stops: const [0, 0.62, 1],
    colors: [cardGradientStart, cardGradientMid, cardGradientEnd],
  );

  /// Share sheet "Night" background.
  LinearGradient get shareNight => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [shareNightStart, shareNightEnd],
  );

  /// Premium badge on the watermark row.
  LinearGradient get premiumGradient =>
      LinearGradient(colors: [premiumGradientStart, premiumGradientEnd]);

  @override
  AppColors copyWith({
    Color? backgroundDefault,
    Color? backgroundSurface,
    Color? backgroundElevated,
    Color? backgroundOverlay,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? textInverse,
    Color? borderDefault,
    Color? borderSubtle,
    Color? buttonPrimary,
    Color? buttonPrimaryDisabled,
    Color? buttonPrimaryPressed,
    Color? buttonSecondary,
    Color? buttonSecondaryBorder,
    Color? buttonIcon,
    Color? buttonGlass,
    Color? buttonGlassBorder,
    Color? buttonInverse,
    Color? statusSuccess,
    Color? statusError,
    Color? statusWarning,
    Color? statusSuccessSurface,
    Color? statusErrorSurface,
    Color? statusWarningSurface,
    Color? inputBackground,
    Color? inputBorderDefault,
    Color? inputBorderFocus,
    Color? inputPlaceholder,
    Color? brandDefault,
    Color? brandSoft,
    Color? accentDefault,
    Color? groupBackground,
    Color? toastBackground,
    Color? dialogBackground,
    Color? segmentOn,
    Color? cardText,
    Color? cardAccent,
    Color? cardGradientStart,
    Color? cardGradientMid,
    Color? cardGradientEnd,
    Color? sharePattern,
    Color? shareNightStart,
    Color? shareNightEnd,
    Color? premiumGradientStart,
    Color? premiumGradientEnd,
    Color? dialogAction,
  }) {
    return AppColors(
      backgroundDefault: backgroundDefault ?? this.backgroundDefault,
      backgroundSurface: backgroundSurface ?? this.backgroundSurface,
      backgroundElevated: backgroundElevated ?? this.backgroundElevated,
      backgroundOverlay: backgroundOverlay ?? this.backgroundOverlay,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      textInverse: textInverse ?? this.textInverse,
      borderDefault: borderDefault ?? this.borderDefault,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonPrimaryDisabled:
          buttonPrimaryDisabled ?? this.buttonPrimaryDisabled,
      buttonPrimaryPressed: buttonPrimaryPressed ?? this.buttonPrimaryPressed,
      buttonSecondary: buttonSecondary ?? this.buttonSecondary,
      buttonSecondaryBorder:
          buttonSecondaryBorder ?? this.buttonSecondaryBorder,
      buttonIcon: buttonIcon ?? this.buttonIcon,
      buttonGlass: buttonGlass ?? this.buttonGlass,
      buttonGlassBorder: buttonGlassBorder ?? this.buttonGlassBorder,
      buttonInverse: buttonInverse ?? this.buttonInverse,
      statusSuccess: statusSuccess ?? this.statusSuccess,
      statusError: statusError ?? this.statusError,
      statusWarning: statusWarning ?? this.statusWarning,
      statusSuccessSurface: statusSuccessSurface ?? this.statusSuccessSurface,
      statusErrorSurface: statusErrorSurface ?? this.statusErrorSurface,
      statusWarningSurface: statusWarningSurface ?? this.statusWarningSurface,
      inputBackground: inputBackground ?? this.inputBackground,
      inputBorderDefault: inputBorderDefault ?? this.inputBorderDefault,
      inputBorderFocus: inputBorderFocus ?? this.inputBorderFocus,
      inputPlaceholder: inputPlaceholder ?? this.inputPlaceholder,
      brandDefault: brandDefault ?? this.brandDefault,
      brandSoft: brandSoft ?? this.brandSoft,
      accentDefault: accentDefault ?? this.accentDefault,
      groupBackground: groupBackground ?? this.groupBackground,
      toastBackground: toastBackground ?? this.toastBackground,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      segmentOn: segmentOn ?? this.segmentOn,
      cardText: cardText ?? this.cardText,
      cardAccent: cardAccent ?? this.cardAccent,
      cardGradientStart: cardGradientStart ?? this.cardGradientStart,
      cardGradientMid: cardGradientMid ?? this.cardGradientMid,
      cardGradientEnd: cardGradientEnd ?? this.cardGradientEnd,
      sharePattern: sharePattern ?? this.sharePattern,
      shareNightStart: shareNightStart ?? this.shareNightStart,
      shareNightEnd: shareNightEnd ?? this.shareNightEnd,
      premiumGradientStart: premiumGradientStart ?? this.premiumGradientStart,
      premiumGradientEnd: premiumGradientEnd ?? this.premiumGradientEnd,
      dialogAction: dialogAction ?? this.dialogAction,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      backgroundDefault: l(backgroundDefault, other.backgroundDefault),
      backgroundSurface: l(backgroundSurface, other.backgroundSurface),
      backgroundElevated: l(backgroundElevated, other.backgroundElevated),
      backgroundOverlay: l(backgroundOverlay, other.backgroundOverlay),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textTertiary: l(textTertiary, other.textTertiary),
      textDisabled: l(textDisabled, other.textDisabled),
      textInverse: l(textInverse, other.textInverse),
      borderDefault: l(borderDefault, other.borderDefault),
      borderSubtle: l(borderSubtle, other.borderSubtle),
      buttonPrimary: l(buttonPrimary, other.buttonPrimary),
      buttonPrimaryDisabled: l(
        buttonPrimaryDisabled,
        other.buttonPrimaryDisabled,
      ),
      buttonPrimaryPressed: l(buttonPrimaryPressed, other.buttonPrimaryPressed),
      buttonSecondary: l(buttonSecondary, other.buttonSecondary),
      buttonSecondaryBorder: l(
        buttonSecondaryBorder,
        other.buttonSecondaryBorder,
      ),
      buttonIcon: l(buttonIcon, other.buttonIcon),
      buttonGlass: l(buttonGlass, other.buttonGlass),
      buttonGlassBorder: l(buttonGlassBorder, other.buttonGlassBorder),
      buttonInverse: l(buttonInverse, other.buttonInverse),
      statusSuccess: l(statusSuccess, other.statusSuccess),
      statusError: l(statusError, other.statusError),
      statusWarning: l(statusWarning, other.statusWarning),
      statusSuccessSurface: l(statusSuccessSurface, other.statusSuccessSurface),
      statusErrorSurface: l(statusErrorSurface, other.statusErrorSurface),
      statusWarningSurface: l(statusWarningSurface, other.statusWarningSurface),
      inputBackground: l(inputBackground, other.inputBackground),
      inputBorderDefault: l(inputBorderDefault, other.inputBorderDefault),
      inputBorderFocus: l(inputBorderFocus, other.inputBorderFocus),
      inputPlaceholder: l(inputPlaceholder, other.inputPlaceholder),
      brandDefault: l(brandDefault, other.brandDefault),
      brandSoft: l(brandSoft, other.brandSoft),
      accentDefault: l(accentDefault, other.accentDefault),
      groupBackground: l(groupBackground, other.groupBackground),
      toastBackground: l(toastBackground, other.toastBackground),
      dialogBackground: l(dialogBackground, other.dialogBackground),
      segmentOn: l(segmentOn, other.segmentOn),
      cardText: l(cardText, other.cardText),
      cardAccent: l(cardAccent, other.cardAccent),
      cardGradientStart: l(cardGradientStart, other.cardGradientStart),
      cardGradientMid: l(cardGradientMid, other.cardGradientMid),
      cardGradientEnd: l(cardGradientEnd, other.cardGradientEnd),
      sharePattern: l(sharePattern, other.sharePattern),
      shareNightStart: l(shareNightStart, other.shareNightStart),
      shareNightEnd: l(shareNightEnd, other.shareNightEnd),
      premiumGradientStart: l(premiumGradientStart, other.premiumGradientStart),
      premiumGradientEnd: l(premiumGradientEnd, other.premiumGradientEnd),
      dialogAction: l(dialogAction, other.dialogAction),
    );
  }
}
