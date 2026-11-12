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
  static const calculationMethodKey = 'prayer_calculation_method';
  static const asrMethodKey = 'prayer_asr_method';
  static const hijriAdjustmentKey = 'prayer_hijri_adjustment';
  static const promptsPausedKey = 'prayer_prompts_paused';
  static const prayedDayKey = 'prayer_prayed_day';
  static const prayedIdsKey = 'prayer_prayed_ids';
  static const locationCacheKey = 'location_cache';
  static const alertModesKey = 'prayer_alert_modes';
  static const alertOffsetsKey = 'prayer_alert_offsets';
  static const adhanVoiceKey = 'prayer_adhan_voice';
  static const jumuahEarlyKey = 'prayer_jumuah_early';
  static const alertsEnabledKey = 'prayer_alerts_enabled';
  static const dailyAyahEnabledKey = 'prayer_daily_ayah_enabled';
  static const dailyAyahSlotKey = 'prayer_daily_ayah_slot';

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

  /// Null means the calculation method follows the country.
  String? get calculationMethodCode => _prefs.getString(calculationMethodKey);

  Future<void> setCalculationMethodCode(String? code) {
    if (code == null) return _prefs.remove(calculationMethodKey);
    return _prefs.setString(calculationMethodKey, code);
  }

  String? get asrMethodCode => _prefs.getString(asrMethodKey);

  Future<void> setAsrMethodCode(String code) =>
      _prefs.setString(asrMethodKey, code);

  int get hijriAdjustment => _prefs.getInt(hijriAdjustmentKey) ?? 0;

  Future<void> setHijriAdjustment(int days) =>
      _prefs.setInt(hijriAdjustmentKey, days);

  bool get promptsPaused => _prefs.getBool(promptsPausedKey) ?? false;

  Future<void> setPromptsPaused({required bool value}) =>
      _prefs.setBool(promptsPausedKey, value);

  /// `fajr:adhan,dhuhr:notify,...`. Null until the user changes a mode.
  String? get alertModes => _prefs.getString(alertModesKey);

  Future<void> setAlertModes(String value) =>
      _prefs.setString(alertModesKey, value);

  String? get alertOffsets => _prefs.getString(alertOffsetsKey);

  Future<void> setAlertOffsets(String value) =>
      _prefs.setString(alertOffsetsKey, value);

  String? get adhanVoice => _prefs.getString(adhanVoiceKey);

  Future<void> setAdhanVoice(String value) =>
      _prefs.setString(adhanVoiceKey, value);

  bool get jumuahEarly => _prefs.getBool(jumuahEarlyKey) ?? false;

  Future<void> setJumuahEarly({required bool value}) =>
      _prefs.setBool(jumuahEarlyKey, value);

  /// Null until onboarding writes a choice. Callers then treat a finished
  /// onboarding as enabled.
  bool? get alertsEnabled => _prefs.getBool(alertsEnabledKey);

  Future<void> setAlertsEnabled(bool value) =>
      _prefs.setBool(alertsEnabledKey, value);

  bool? get dailyAyahEnabled => _prefs.getBool(dailyAyahEnabledKey);

  Future<void> setDailyAyahEnabled(bool value) =>
      _prefs.setBool(dailyAyahEnabledKey, value);

  String? get dailyAyahSlot => _prefs.getString(dailyAyahSlotKey);

  Future<void> setDailyAyahSlot(String value) =>
      _prefs.setString(dailyAyahSlotKey, value);

  String? get prayedDay => _prefs.getString(prayedDayKey);

  String? get prayedIds => _prefs.getString(prayedIdsKey);

  Future<void> setPrayed({required String day, required String ids}) async {
    await _prefs.setString(prayedDayKey, day);
    await _prefs.setString(prayedIdsKey, ids);
  }

  /// `latitude,longitude`. Null when no GPS fix has been stored.
  String? get locationCache => _prefs.getString(locationCacheKey);

  Future<void> setLocationCache(String? value) {
    if (value == null) return _prefs.remove(locationCacheKey);
    return _prefs.setString(locationCacheKey, value);
  }
}

final appPreferencesProvider = Provider<AppPreferences>(
  (ref) => AppPreferences(ref.watch(sharedPreferencesProvider)),
);
