import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/infrastructure_providers.dart';
import '../../../core/storage/app_preferences.dart';
import '../../prayer_alerts/domain/alert_codec.dart';
import '../../prayer_alerts/domain/alert_settings.dart';
import '../domain/calculation.dart';
import '../domain/home_day.dart';

export '../../../app/di/home_ports.dart';

class PrayerSettingsController extends Notifier<PrayerSettings> {
  @override
  PrayerSettings build() {
    ref.watch(preferenceRevisionProvider);
    final prefs = ref.watch(appPreferencesProvider);
    return PrayerSettings(
      methodOverride: calculationMethodFromCode(prefs.calculationMethodCode),
      asr: asrMethodFromCode(prefs.asrMethodCode),
      hijriAdjustment: prefs.hijriAdjustment.clamp(-1, 1),
      promptsPaused: prefs.promptsPaused,
    );
  }

  Future<void> setMethod(CalculationMethodId? method) async {
    await ref
        .read(appPreferencesProvider)
        .setCalculationMethodCode(method?.name);
    _publish(
      state.copyWith(methodOverride: method, clearMethod: method == null),
    );
  }

  Future<void> setAsr(AsrMethod asr) async {
    await ref.read(appPreferencesProvider).setAsrMethodCode(asr.name);
    _publish(state.copyWith(asr: asr));
  }

  Future<void> setHijriAdjustment(int days) async {
    final clamped = days.clamp(-1, 1);
    await ref.read(appPreferencesProvider).setHijriAdjustment(clamped);
    _publish(state.copyWith(hijriAdjustment: clamped));
  }

  Future<void> setPromptsPaused({required bool value}) async {
    await ref.read(appPreferencesProvider).setPromptsPaused(value: value);
    _publish(state.copyWith(promptsPaused: value));
  }

  void _publish(PrayerSettings next) {
    if (!ref.mounted) return;
    state = next;
    ref.read(preferenceRevisionProvider.notifier).bump();
  }
}

final prayerSettingsProvider =
    NotifierProvider<PrayerSettingsController, PrayerSettings>(
      PrayerSettingsController.new,
    );

class DebugSession {
  const DebugSession({this.clock, this.preview = HomePreview.live});

  final DateTime? clock;
  final HomePreview preview;
}

class DebugSessionController extends Notifier<DebugSession> {
  @override
  DebugSession build() => const DebugSession();

  void setMinute(int minute) {
    final base = state.clock ?? DateTime.now();
    state = DebugSession(
      clock: DateTime(
        base.year,
        base.month,
        base.day,
        minute ~/ 60,
        minute % 60,
      ),
      preview: state.preview,
    );
  }

  void shiftDays(int days) {
    final base = state.clock ?? DateTime.now();
    state = DebugSession(
      clock: base.add(Duration(days: days)),
      preview: state.preview,
    );
  }

  void setPreview(HomePreview preview) {
    state = DebugSession(clock: state.clock, preview: preview);
  }

  void useDeviceClock() {
    state = DebugSession(preview: state.preview);
  }
}

final debugSessionProvider =
    NotifierProvider<DebugSessionController, DebugSession>(
      DebugSessionController.new,
    );

/// Alert choices as stored. Home reads this so the bells match Prayer alerts.
final displayedAlertSettingsProvider = Provider<PrayerAlertSettings>((ref) {
  ref.watch(preferenceRevisionProvider);
  final prefs = ref.watch(appPreferencesProvider);
  return decodeAlertSettings(
    AlertPrefsFields(
      modes: prefs.alertModes,
      offsets: prefs.alertOffsets,
      voice: prefs.adhanVoice,
      promptsPaused: prefs.promptsPaused,
      jumuahEarly: prefs.jumuahEarly,
      alertsEnabled: prefs.alertsEnabled,
      onboardingCompleted: prefs.onboardingCompleted,
      dailyAyahEnabled: prefs.dailyAyahEnabled,
      dailyAyahSlot: prefs.dailyAyahSlot,
    ),
  );
});
