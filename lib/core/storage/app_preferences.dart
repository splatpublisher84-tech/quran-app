import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/infrastructure_providers.dart';

/// Typed access to small key value settings. Keys live here only.
class AppPreferences {
  AppPreferences(this._prefs);

  static const onboardingKey = 'onboarding_completed';
  static const quranLanguageKey = 'quran_language';
  static const arabicTextSizeKey = 'arabic_text_size';
  static const lastReadKey = 'quran_last_read';

  final SharedPreferences _prefs;

  bool get onboardingCompleted => _prefs.getBool(onboardingKey) ?? false;

  Future<void> setOnboardingCompleted({required bool value}) =>
      _prefs.setBool(onboardingKey, value);

  /// Translation language code (`en`, `id`, `ur`, `tr`). Null follows the device.
  String? get quranLanguageCode => _prefs.getString(quranLanguageKey);

  Future<void> setQuranLanguageCode(String code) =>
      _prefs.setString(quranLanguageKey, code);

  /// `small`, `medium` or `large`. Null means medium.
  String? get arabicTextSizeCode => _prefs.getString(arabicTextSizeKey);

  Future<void> setArabicTextSizeCode(String code) =>
      _prefs.setString(arabicTextSizeKey, code);

  /// Last opened ayah, stored as `surah:ayah`.
  String? get lastRead => _prefs.getString(lastReadKey);

  Future<void> setLastRead(String key) => _prefs.setString(lastReadKey, key);
}

final appPreferencesProvider = Provider<AppPreferences>(
  (ref) => AppPreferences(ref.watch(sharedPreferencesProvider)),
);
