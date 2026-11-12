import 'package:flutter_riverpod/misc.dart';

import '../../../core/storage/app_preferences.dart';
import '../data/prefs_alert_settings_repository.dart';
import '../presentation/alert_controller.dart';

/// Binds alert settings to the preference store.
List<Override> alertFeatureOverrides() => [
  alertSettingsRepositoryProvider.overrideWith((ref) {
    return PrefsAlertSettingsRepository(ref.watch(appPreferencesProvider));
  }),
];
