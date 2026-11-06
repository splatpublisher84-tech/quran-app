import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/app_preferences.dart';

/// Holds whether onboarding is complete. The router redirects on changes.
class OnboardingController extends Notifier<bool> {
  @override
  bool build() => ref.watch(appPreferencesProvider).onboardingCompleted;

  Future<void> complete() async {
    await ref.read(appPreferencesProvider).setOnboardingCompleted(value: true);
    state = true;
  }
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, bool>(OnboardingController.new);
