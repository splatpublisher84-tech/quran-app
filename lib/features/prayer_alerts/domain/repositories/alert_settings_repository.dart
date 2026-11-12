import '../alert_settings.dart';

abstract interface class AlertSettingsRepository {
  PrayerAlertSettings read();
  Future<void> save(PrayerAlertSettings settings);
}
