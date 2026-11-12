import 'alert_settings.dart';

/// Raw preference fields. A missing [alertsEnabled] means the user finished
/// onboarding before this switch existed, so [onboardingCompleted] decides.
class AlertPrefsFields {
  const AlertPrefsFields({
    this.modes,
    this.offsets,
    this.voice,
    this.promptsPaused = false,
    this.jumuahEarly = false,
    this.alertsEnabled,
    this.onboardingCompleted = false,
    this.dailyAyahEnabled,
    this.dailyAyahSlot,
  });

  final String? modes;
  final String? offsets;
  final String? voice;
  final bool promptsPaused;
  final bool jumuahEarly;
  final bool? alertsEnabled;
  final bool onboardingCompleted;
  final bool? dailyAyahEnabled;
  final String? dailyAyahSlot;
}

PrayerAlertSettings decodeAlertSettings(AlertPrefsFields fields) {
  final modes = _pairs(fields.modes);
  final offsets = _pairs(fields.offsets);
  AlertMode mode(String key) => _mode(modes[key]) ?? AlertMode.adhan;
  int offset(String key) =>
      clampAlertOffset(int.tryParse(offsets[key] ?? '') ?? 0);
  return PrayerAlertSettings(
    fajr: mode('fajr'),
    dhuhr: mode('dhuhr'),
    asr: mode('asr'),
    maghrib: mode('maghrib'),
    isha: mode('isha'),
    fajrOffset: offset('fajr'),
    dhuhrOffset: offset('dhuhr'),
    asrOffset: offset('asr'),
    maghribOffset: offset('maghrib'),
    ishaOffset: offset('isha'),
    voice: _voice(fields.voice) ?? AdhanVoice.makkah,
    promptsPaused: fields.promptsPaused,
    jumuahEarly: fields.jumuahEarly,
    dailyAyahEnabled: fields.dailyAyahEnabled ?? true,
    dailyAyahSlot: _slot(fields.dailyAyahSlot) ?? DailyAyahSlot.afterFajr,
    enabled: fields.alertsEnabled ?? fields.onboardingCompleted,
  );
}

AlertPrefsFields encodeAlertSettings(PrayerAlertSettings settings) {
  String modePairs() => [
    'fajr:${settings.fajr.name}',
    'dhuhr:${settings.dhuhr.name}',
    'asr:${settings.asr.name}',
    'maghrib:${settings.maghrib.name}',
    'isha:${settings.isha.name}',
  ].join(',');
  String offsetPairs() => [
    'fajr:${settings.fajrOffset}',
    'dhuhr:${settings.dhuhrOffset}',
    'asr:${settings.asrOffset}',
    'maghrib:${settings.maghribOffset}',
    'isha:${settings.ishaOffset}',
  ].join(',');
  return AlertPrefsFields(
    modes: modePairs(),
    offsets: offsetPairs(),
    voice: settings.voice.name,
    promptsPaused: settings.promptsPaused,
    jumuahEarly: settings.jumuahEarly,
    alertsEnabled: settings.enabled,
    dailyAyahEnabled: settings.dailyAyahEnabled,
    dailyAyahSlot: settings.dailyAyahSlot.name,
  );
}

Map<String, String> _pairs(String? raw) {
  final result = <String, String>{};
  if (raw == null || raw.isEmpty) return result;
  for (final part in raw.split(',')) {
    final bits = part.split(':');
    if (bits.length == 2 && bits[0].isNotEmpty) result[bits[0]] = bits[1];
  }
  return result;
}

AlertMode? _mode(String? name) {
  for (final mode in AlertMode.values) {
    if (mode.name == name) return mode;
  }
  return null;
}

AdhanVoice? _voice(String? name) {
  for (final voice in AdhanVoice.values) {
    if (voice.name == name) return voice;
  }
  return null;
}

DailyAyahSlot? _slot(String? name) {
  for (final slot in DailyAyahSlot.values) {
    if (slot.name == name) return slot;
  }
  return null;
}
