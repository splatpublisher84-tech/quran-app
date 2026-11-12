import 'alert_settings.dart';

/// Adhan voices and the Android channel each notification kind uses.
///
/// Channel ids are versioned. v1 ships without a clip, so the system default
/// sound plays. Adding a wav later needs a new version: Android keeps the
/// sound from the first time it created that channel id.
abstract final class AdhanVoiceCatalog {
  static const bool soundsBundled = false;

  static const notifyChannelId = 'salah_notify_v1';
  static const dailyAyahChannelId = 'daily_ayah_v1';
  static const suhoorChannelId = 'suhoor_v1';
  static const iftarChannelId = 'iftar_v1';
  static const jumuahChannelId = 'jumuah_v1';

  static String channelId(AdhanVoice voice) => switch (voice) {
    AdhanVoice.makkah => 'adhan_makkah_v1',
    AdhanVoice.madinah => 'adhan_madinah_v1',
    AdhanVoice.alAqsa => 'adhan_alaqsa_v1',
  };

  static String rawName(AdhanVoice voice) => switch (voice) {
    AdhanVoice.makkah => 'adhan_makkah',
    AdhanVoice.madinah => 'adhan_madinah',
    AdhanVoice.alAqsa => 'adhan_alaqsa',
  };

  /// Null means the platform default sound.
  static String? soundResource(
    AdhanVoice voice, {
    bool bundled = soundsBundled,
  }) => bundled ? rawName(voice) : null;

  static String channelFor({
    required AlertMode mode,
    required AdhanVoice voice,
  }) => mode == AlertMode.adhan ? channelId(voice) : notifyChannelId;
}
