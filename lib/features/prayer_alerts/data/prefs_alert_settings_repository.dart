import '../../../core/storage/app_preferences.dart';
import '../domain/alert_codec.dart';
import '../domain/alert_settings.dart';
import '../domain/repositories/alert_settings_repository.dart';

final class PrefsAlertSettingsRepository implements AlertSettingsRepository {
  PrefsAlertSettingsRepository(this._prefs);

  final AppPreferences _prefs;

  @override
  PrayerAlertSettings read() {
    return decodeAlertSettings(
      AlertPrefsFields(
        modes: _prefs.alertModes,
        offsets: _prefs.alertOffsets,
        voice: _prefs.adhanVoice,
        promptsPaused: _prefs.promptsPaused,
        jumuahEarly: _prefs.jumuahEarly,
        alertsEnabled: _prefs.alertsEnabled,
        onboardingCompleted: _prefs.onboardingCompleted,
        dailyAyahEnabled: _prefs.dailyAyahEnabled,
        dailyAyahSlot: _prefs.dailyAyahSlot,
      ),
    );
  }

  @override
  Future<void> save(PrayerAlertSettings settings) async {
    final encoded = encodeAlertSettings(settings);
    await _prefs.setAlertModes(encoded.modes ?? '');
    await _prefs.setAlertOffsets(encoded.offsets ?? '');
    await _prefs.setAdhanVoice(encoded.voice ?? AdhanVoice.makkah.name);
    await _prefs.setJumuahEarly(value: encoded.jumuahEarly);
    await _prefs.setAlertsEnabled(encoded.alertsEnabled ?? settings.enabled);
    await _prefs.setDailyAyahEnabled(
      encoded.dailyAyahEnabled ?? settings.dailyAyahEnabled,
    );
    await _prefs.setDailyAyahSlot(
      encoded.dailyAyahSlot ?? settings.dailyAyahSlot.name,
    );
    await _prefs.setPromptsPaused(value: settings.promptsPaused);
  }
}
