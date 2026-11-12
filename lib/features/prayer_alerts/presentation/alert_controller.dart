import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/home_ports.dart';
import '../../../core/di/infrastructure_providers.dart';
import '../../../core/di/notification_providers.dart';
import '../../../core/platform/notification_types.dart';
import '../../../core/platform/permission_service.dart';
import '../../../core/storage/app_preferences.dart';
import '../../../i18n/strings.g.dart';
import '../../home/domain/calculation.dart';
import '../../home/domain/prayer_math.dart';
import '../domain/alert_settings.dart';
import '../domain/repositories/alert_settings_repository.dart';
import '../domain/usecases/reschedule_alerts.dart';
import 'alert_text.dart';

final alertSettingsRepositoryProvider = Provider<AlertSettingsRepository>(
  (ref) => throw UnimplementedError(
    'alertSettingsRepositoryProvider must be overridden',
  ),
);

class AlertSettingsController extends Notifier<PrayerAlertSettings> {
  @override
  PrayerAlertSettings build() {
    ref.watch(preferenceRevisionProvider);
    return ref.watch(alertSettingsRepositoryProvider).read();
  }

  Future<void> setMode(PrayerId id, AlertMode mode) {
    return _save(state.withMode(id, mode));
  }

  Future<void> setAll(AlertMode mode) => _save(state.withAll(mode));

  Future<void> setOffset(PrayerId id, int minutes) {
    return _save(state.withOffset(id, minutes));
  }

  Future<void> setVoice(AdhanVoice voice) {
    return _save(state.copyWith(voice: voice));
  }

  Future<void> setPaused({required bool value}) {
    return _save(state.copyWith(promptsPaused: value));
  }

  Future<void> setJumuahEarly({required bool value}) {
    return _save(state.copyWith(jumuahEarly: value));
  }

  Future<void> setEnabled({required bool value}) {
    return _save(state.copyWith(enabled: value));
  }

  /// Records that the user wants alerts, then asks the system.
  Future<void> turnOn() async {
    final before = await ref.read(notificationAccessProvider.future);
    await _save(state.copyWith(enabled: true));
    if (!ref.mounted) return;
    await turnOnNotificationPermission(
      current: before,
      permissions: ref.read(permissionServiceProvider),
    );
    if (!ref.mounted) return;
    ref.invalidate(notificationAccessProvider);
    ref.read(preferenceRevisionProvider.notifier).bump();
  }

  Future<void> _save(PrayerAlertSettings next) async {
    state = next;
    await ref.read(alertSettingsRepositoryProvider).save(next);
    if (!ref.mounted) return;
    ref.read(preferenceRevisionProvider.notifier).bump();
  }
}

final alertSettingsProvider =
    NotifierProvider<AlertSettingsController, PrayerAlertSettings>(
      AlertSettingsController.new,
    );

/// Replaces the pending set when location, calculation or alert settings change.
final alertRescheduleProvider = FutureProvider<void>((ref) async {
  ref.watch(preferenceRevisionProvider);
  ref.watch(locationSnapshotProvider);
  final settings = ref.watch(alertSettingsProvider);
  final access = await ref.watch(notificationAccessProvider.future);
  final prefs = ref.watch(appPreferencesProvider);
  await RescheduleAlerts(
    calculator: ref.watch(prayerTimesCalculatorProvider),
    location: ref.watch(locationRepositoryProvider),
    scheduler: ref.watch(notificationSchedulerProvider),
    clock: ref.watch(clockProvider),
  ).call(
    settings: settings,
    methodOverride: calculationMethodFromCode(prefs.calculationMethodCode),
    asr: asrMethodFromCode(prefs.asrMethodCode),
    hijriAdjustment: prefs.hijriAdjustment.clamp(-1, 1),
    osGranted: access == NotificationPermissionStatus.granted,
    text: (alert) => describeAlert(alert, t),
  );
});
