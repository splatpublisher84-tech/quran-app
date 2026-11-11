import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/app_preferences.dart';
import '../domain/calculation.dart';
import '../domain/home_day.dart';
import '../domain/location.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/repositories/prayer_times_calculator.dart';
import '../domain/usecases/location_use_cases.dart';

final prayerTimesCalculatorProvider = Provider<PrayerTimesCalculator>(
  (ref) => throw UnimplementedError(
    'prayerTimesCalculatorProvider must be overridden',
  ),
);

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) =>
      throw UnimplementedError('locationRepositoryProvider must be overridden'),
);

final resolveUserLocationProvider = Provider<ResolveUserLocation>(
  (ref) => ResolveUserLocation(ref.watch(locationRepositoryProvider)),
);

final requestLocationPermissionProvider = Provider<RequestLocationPermission>(
  (ref) => RequestLocationPermission(ref.watch(locationRepositoryProvider)),
);

/// Cached until Home invalidates it on resume or after a permission change.
final locationSnapshotProvider = FutureProvider<LocationSnapshot>((ref) async {
  final result = await ref.watch(resolveUserLocationProvider).call();
  final value = result.valueOrNull;
  if (value == null) {
    throw StateError(result.failureOrNull?.message ?? 'Location failed');
  }
  return value;
});

class PrayerSettingsController extends Notifier<PrayerSettings> {
  @override
  PrayerSettings build() {
    final prefs = ref.watch(appPreferencesProvider);
    return PrayerSettings(
      methodOverride: _method(prefs.calculationMethodCode),
      asr: _asr(prefs.asrMethodCode),
      hijriAdjustment: prefs.hijriAdjustment.clamp(-1, 1),
      promptsPaused: prefs.promptsPaused,
    );
  }

  Future<void> setMethod(CalculationMethodId? method) async {
    await ref
        .read(appPreferencesProvider)
        .setCalculationMethodCode(method?.name);
    state = state.copyWith(methodOverride: method, clearMethod: method == null);
  }

  Future<void> setAsr(AsrMethod asr) async {
    await ref.read(appPreferencesProvider).setAsrMethodCode(asr.name);
    state = state.copyWith(asr: asr);
  }

  Future<void> setHijriAdjustment(int days) async {
    final clamped = days.clamp(-1, 1);
    await ref.read(appPreferencesProvider).setHijriAdjustment(clamped);
    state = state.copyWith(hijriAdjustment: clamped);
  }

  Future<void> setPromptsPaused({required bool value}) async {
    await ref.read(appPreferencesProvider).setPromptsPaused(value: value);
    state = state.copyWith(promptsPaused: value);
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

CalculationMethodId? _method(String? code) {
  if (code == null) return null;
  for (final method in CalculationMethodId.values) {
    if (method.name == code) return method;
  }
  return null;
}

AsrMethod _asr(String? code) {
  for (final method in AsrMethod.values) {
    if (method.name == code) return method;
  }
  return AsrMethod.standard;
}
