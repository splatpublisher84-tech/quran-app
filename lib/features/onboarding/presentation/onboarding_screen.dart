import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/design_system.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';
import 'onboarding_controller.dart';

/// M1 placeholder. The full three step onboarding arrives in M4.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              AppLargeHeader(
                title: t.onboarding.title,
                subtitle: t.onboarding.subtitle,
              ),
              const Spacer(),
              AppButton(
                label: t.onboarding.start,
                expand: true,
                onPressed: () =>
                    ref.read(onboardingControllerProvider.notifier).complete(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
