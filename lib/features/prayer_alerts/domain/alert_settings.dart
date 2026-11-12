import 'package:freezed_annotation/freezed_annotation.dart';

import '../../home/domain/prayer_math.dart';

part 'alert_settings.freezed.dart';

enum AlertMode { adhan, notify, off }

enum AdhanVoice { makkah, madinah, alAqsa }

/// When the daily ayah reminder is posted, relative to a prayer.
enum DailyAyahSlot { afterFajr, afterMaghrib }

/// How early a salah alert may fire, in minutes. Zero is on time.
const List<int> alertLeadMinutes = [0, 5, 10, 15, 30];

/// Per-prayer alert choices, shared by Home and the Prayer alerts screen.
@freezed
abstract class PrayerAlertSettings with _$PrayerAlertSettings {
  const PrayerAlertSettings._();

  const factory PrayerAlertSettings({
    @Default(AlertMode.adhan) AlertMode fajr,
    @Default(AlertMode.adhan) AlertMode dhuhr,
    @Default(AlertMode.adhan) AlertMode asr,
    @Default(AlertMode.adhan) AlertMode maghrib,
    @Default(AlertMode.adhan) AlertMode isha,
    @Default(0) int fajrOffset,
    @Default(0) int dhuhrOffset,
    @Default(0) int asrOffset,
    @Default(0) int maghribOffset,
    @Default(0) int ishaOffset,
    @Default(AdhanVoice.makkah) AdhanVoice voice,
    @Default(false) bool promptsPaused,
    @Default(false) bool jumuahEarly,
    @Default(true) bool dailyAyahEnabled,
    @Default(DailyAyahSlot.afterFajr) DailyAyahSlot dailyAyahSlot,
    @Default(true) bool enabled,
  }) = _PrayerAlertSettings;

  AlertMode modeOf(PrayerId id) => switch (id) {
    PrayerId.fajr => fajr,
    PrayerId.dhuhr => dhuhr,
    PrayerId.asr => asr,
    PrayerId.maghrib => maghrib,
    PrayerId.isha => isha,
  };

  int offsetOf(PrayerId id) => switch (id) {
    PrayerId.fajr => fajrOffset,
    PrayerId.dhuhr => dhuhrOffset,
    PrayerId.asr => asrOffset,
    PrayerId.maghrib => maghribOffset,
    PrayerId.isha => ishaOffset,
  };

  /// The mode when every prayer matches, otherwise null.
  AlertMode? get sharedMode {
    if (dhuhr == fajr && asr == fajr && maghrib == fajr && isha == fajr) {
      return fajr;
    }
    return null;
  }

  PrayerAlertSettings withMode(PrayerId id, AlertMode mode) => switch (id) {
    PrayerId.fajr => copyWith(fajr: mode),
    PrayerId.dhuhr => copyWith(dhuhr: mode),
    PrayerId.asr => copyWith(asr: mode),
    PrayerId.maghrib => copyWith(maghrib: mode),
    PrayerId.isha => copyWith(isha: mode),
  };

  PrayerAlertSettings withOffset(PrayerId id, int minutes) {
    final clamped = clampAlertOffset(minutes);
    return switch (id) {
      PrayerId.fajr => copyWith(fajrOffset: clamped),
      PrayerId.dhuhr => copyWith(dhuhrOffset: clamped),
      PrayerId.asr => copyWith(asrOffset: clamped),
      PrayerId.maghrib => copyWith(maghribOffset: clamped),
      PrayerId.isha => copyWith(ishaOffset: clamped),
    };
  }

  PrayerAlertSettings withAll(AlertMode mode) =>
      copyWith(fajr: mode, dhuhr: mode, asr: mode, maghrib: mode, isha: mode);
}

/// Snaps a stored minute offset onto [alertLeadMinutes].
///
/// Offsets are zero or negative. A late alert, or a value between two
/// marks, becomes the nearest mark. A tie keeps the smaller lead.
int clampAlertOffset(int minutes) {
  final wanted = -minutes;
  var lead = alertLeadMinutes.first;
  var distance = (wanted - lead).abs();
  for (final candidate in alertLeadMinutes.skip(1)) {
    final next = (wanted - candidate).abs();
    if (next < distance) {
      lead = candidate;
      distance = next;
    }
  }
  return -lead;
}
