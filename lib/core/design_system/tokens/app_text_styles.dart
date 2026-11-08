import 'package:flutter/material.dart';

/// Typography tokens, generated from the handoff table in
/// `dev-handoff/01-design-tokens` (sizes in pt on a 393x852 screen).
/// Colors are applied at the call site with `copyWith` from `AppColors`,
/// so the same style works in light and dark.
abstract final class AppTextStyles {
  static const String uiFamily = 'Onest';
  static const String readingFamily = 'Literata';
  static const String arabicFamily = 'Amiri';
  static const String urduFamily = 'NotoNastaliqUrdu';

  // UI (Onest). Line height left to the font default, as in the handoff.
  static const TextStyle uiHeadingLarge = TextStyle(
    fontFamily: uiFamily,
    fontSize: 34,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );

  static const TextStyle uiHeadingMedium = TextStyle(
    fontFamily: uiFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );

  static const TextStyle uiHeadingSmall = TextStyle(
    fontFamily: uiFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle uiBodyRegular = TextStyle(
    fontFamily: uiFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static const TextStyle uiBodyEmphasized = TextStyle(
    fontFamily: uiFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle uiLabelRegular = TextStyle(
    fontFamily: uiFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle uiLabelEmphasized = TextStyle(
    fontFamily: uiFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle uiFootnote = TextStyle(
    fontFamily: uiFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  /// Use with `.toUpperCase()` on the string.
  static const TextStyle uiFootnoteUppercase = TextStyle(
    fontFamily: uiFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.6,
  );

  static const TextStyle uiCaptionRegular = TextStyle(
    fontFamily: uiFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle uiCaptionEmphasized = TextStyle(
    fontFamily: uiFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle uiButtonLarge = TextStyle(
    fontFamily: uiFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );

  static const TextStyle uiButtonMedium = TextStyle(
    fontFamily: uiFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  // Translation text (Literata). Default line height 150%.
  static const TextStyle readingSerifSmall = TextStyle(
    fontFamily: readingFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle readingSerifSmallBold = TextStyle(
    fontFamily: readingFamily,
    fontSize: 17,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static const TextStyle readingSerifMedium = TextStyle(
    fontFamily: readingFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle readingSerifMediumBold = TextStyle(
    fontFamily: readingFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static const TextStyle readingSerifLarge = TextStyle(
    fontFamily: readingFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle readingSerifLargeBold = TextStyle(
    fontFamily: readingFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  // Arabic (Amiri, temporary until a licensed Uthmani font, Q-03).
  static const TextStyle arabicReaderSmall = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.9,
  );

  static const TextStyle arabicReaderMedium = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.9,
  );

  static const TextStyle arabicReaderLarge = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 34,
    fontWeight: FontWeight.w400,
    height: 1.9,
  );

  static const TextStyle arabicCard = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.9,
  );

  static const TextStyle arabicBasmala = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 26,
    fontWeight: FontWeight.w400,
    height: 1.9,
  );

  static const TextStyle arabicLabel = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  /// Urdu translation. RTL, line height 220% (handoff `translation-fonts`).
  static const TextStyle urduBody = TextStyle(
    fontFamily: urduFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 2.2,
  );
}
