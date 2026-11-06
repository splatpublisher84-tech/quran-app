import 'package:flutter/material.dart';

/// Typography tokens. Colors are applied at the call site with `copyWith`
/// from `AppColors`, so the same style works in light and dark.
abstract final class AppTextStyles {
  static const String uiFamily = 'Onest';
  static const String readingFamily = 'Literata';
  static const String arabicFamily = 'Amiri';

  static const TextStyle uiLargeTitle = TextStyle(
    fontFamily: uiFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle uiTitle = TextStyle(
    fontFamily: uiFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle uiHeadline = TextStyle(
    fontFamily: uiFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle uiBody = TextStyle(
    fontFamily: uiFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static const TextStyle uiCaption = TextStyle(
    fontFamily: uiFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle uiLabel = TextStyle(
    fontFamily: uiFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.4,
  );

  static const TextStyle readingSerifBody = TextStyle(
    fontFamily: readingFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.7,
  );

  static const TextStyle readingSerifSmall = TextStyle(
    fontFamily: readingFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const TextStyle arabicBody = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 2,
  );

  static const TextStyle arabicLarge = TextStyle(
    fontFamily: arabicFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.9,
  );
}
