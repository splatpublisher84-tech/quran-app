import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/infrastructure_providers.dart';

/// Typed access to small key value settings. Keys live here only.
class AppPreferences {
  AppPreferences(this._prefs);

  static const onboardingKey = 'onboarding_completed';

  final SharedPreferences _prefs;

  bool get onboardingCompleted => _prefs.getBool(onboardingKey) ?? false;

  Future<void> setOnboardingCompleted({required bool value}) =>
      _prefs.setBool(onboardingKey, value);
}

final appPreferencesProvider = Provider<AppPreferences>(
  (ref) => AppPreferences(ref.watch(sharedPreferencesProvider)),
);
