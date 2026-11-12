import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/home_ports.dart';
import '../../../core/design_system/design_system.dart';
import '../../../core/di/infrastructure_providers.dart';
import '../../../core/di/notification_providers.dart';
import '../../../core/storage/app_preferences.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../home/domain/prayer_math.dart';
import 'onboarding_controller.dart';

/// Welcome, location, then notification permission. No city picker, no paywall.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  var _step = 0;
  var _busy = false;

  @override
  Widget build(BuildContext context) {
    return switch (_step) {
      0 => _Welcome(onStart: () => setState(() => _step = 1)),
      1 => _LocationStep(
        busy: _busy,
        onBack: () => setState(() => _step = 0),
        onUseLocation: _useLocation,
        onNotNow: () => setState(() => _step = 2),
      ),
      _ => _AlertsStep(
        busy: _busy,
        onBack: () => setState(() => _step = 1),
        onTurnOn: _turnOnAlerts,
        onNotNow: () => _finish(enabled: false),
      ),
    };
  }

  Future<void> _useLocation() async {
    setState(() => _busy = true);
    await ref.read(locationRepositoryProvider).requestPermission();
    ref.invalidate(locationSnapshotProvider);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _step = 2;
    });
  }

  Future<void> _turnOnAlerts() async {
    setState(() => _busy = true);
    await ref.read(permissionServiceProvider).requestNotification();
    ref.invalidate(notificationAccessProvider);
    if (!mounted) return;
    await _finish(enabled: true);
  }

  Future<void> _finish({required bool enabled}) async {
    await ref.read(appPreferencesProvider).setAlertsEnabled(enabled);
    if (!mounted) return;
    ref.read(preferenceRevisionProvider.notifier).bump();
    ref.invalidate(notificationAccessProvider);
    await ref.read(onboardingControllerProvider.notifier).complete();
  }
}

class _Welcome extends StatelessWidget {
  const _Welcome({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(gradient: c.cardGradient),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.space32,
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(
                t.onboarding.bismillah,
                textAlign: TextAlign.center,
                style: AppTextStyles.arabicBasmala.copyWith(
                  color: c.cardAccent,
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              Text(
                t.onboarding.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.uiHeadingMedium.copyWith(
                  color: c.cardText,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
              Text(
                t.onboarding.quiet,
                textAlign: TextAlign.center,
                style: AppTextStyles.uiBodyRegular.copyWith(color: c.cardText),
              ),
              const Spacer(),
              const _Dots(index: 0, onDark: true),
              const SizedBox(height: AppSpacing.space16),
              AppButton(
                label: t.onboarding.start,
                expand: true,
                variant: AppButtonVariant.inverse,
                onPressed: onStart,
              ),
              const SizedBox(height: AppSpacing.space24),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationStep extends StatelessWidget {
  const _LocationStep({
    required this.busy,
    required this.onBack,
    required this.onUseLocation,
    required this.onNotNow,
  });

  final bool busy;
  final VoidCallback onBack;
  final VoidCallback onUseLocation;
  final VoidCallback onNotNow;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.space24,
            AppSpacing.space8,
            AppSpacing.space24,
            AppSpacing.space24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppIconButton(
                  icon: Icons.arrow_back_rounded,
                  semanticLabel: t.common.back,
                  onPressed: busy ? null : onBack,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: AppSizes.iconButton,
                      color: c.buttonPrimary,
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    Text(
                      t.onboarding.locationTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.uiHeadingMedium.copyWith(
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    Text(
                      t.onboarding.locationBody,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.uiBodyRegular.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const _Dots(index: 1, onDark: false),
              const SizedBox(height: AppSpacing.space16),
              AppButton(
                label: t.onboarding.useLocation,
                expand: true,
                onPressed: busy ? null : onUseLocation,
              ),
              const SizedBox(height: AppSpacing.space8),
              AppButton(
                label: t.onboarding.notNow,
                expand: true,
                variant: AppButtonVariant.text,
                onPressed: busy ? null : onNotNow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertsStep extends ConsumerWidget {
  const _AlertsStep({
    required this.busy,
    required this.onBack,
    required this.onTurnOn,
    required this.onNotNow,
  });

  final bool busy;
  final VoidCallback onBack;
  final VoidCallback onTurnOn;
  final VoidCallback onNotNow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final c = context.colors;
    final times = ref.watch(todayTimesProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.space24,
            AppSpacing.space8,
            AppSpacing.space24,
            AppSpacing.space24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppIconButton(
                  icon: Icons.arrow_back_rounded,
                  semanticLabel: t.common.back,
                  onPressed: busy ? null : onBack,
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              Text(
                t.onboarding.alertsTitle,
                style: AppTextStyles.uiHeadingMedium.copyWith(
                  color: c.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                t.onboarding.alertsBody,
                style: AppTextStyles.uiBodyRegular.copyWith(
                  color: c.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: c.groupBackground,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: ListView(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.space16,
                    ),
                    children: [
                      for (final id in prayers)
                        _PreviewRow(
                          name: _prayerName(t, id),
                          arabic: prayerArabic[id] ?? '',
                          time: switch (times?.minutesOf(id)) {
                            final minute? => fmtClock(minute),
                            _ => '',
                          },
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              const _Dots(index: 2, onDark: false),
              const SizedBox(height: AppSpacing.space16),
              AppButton(
                label: t.onboarding.turnOnAlerts,
                expand: true,
                onPressed: busy ? null : onTurnOn,
              ),
              const SizedBox(height: AppSpacing.space8),
              AppButton(
                label: t.onboarding.notNow,
                expand: true,
                variant: AppButtonVariant.text,
                onPressed: busy ? null : onNotNow,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _prayerName(Translations t, PrayerId id) => switch (id) {
    PrayerId.fajr => t.home.fajr,
    PrayerId.dhuhr => t.home.dhuhr,
    PrayerId.asr => t.home.asr,
    PrayerId.maghrib => t.home.maghrib,
    PrayerId.isha => t.home.isha,
  };
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({
    required this.name,
    required this.arabic,
    required this.time,
  });

  final String name;
  final String arabic;
  final String time;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      constraints: const BoxConstraints(minHeight: AppSizes.timelineRowHeight),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: c.borderSubtle, width: AppSizes.hairline),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.timelineTimeWidth,
            child: Text(
              time,
              style: AppTextStyles.uiLabelRegular.copyWith(
                color: c.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              name,
              style: AppTextStyles.uiBodyRegular.copyWith(color: c.textPrimary),
            ),
          ),
          Text(
            arabic,
            style: AppTextStyles.arabicLabel.copyWith(color: c.accentDefault),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.index, required this.onDark});

  final int index;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 3; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.space4),
          Container(
            width: i == index ? AppSpacing.space20 : AppSpacing.space8,
            height: AppSpacing.space8,
            decoration: BoxDecoration(
              color: i == index
                  ? (onDark ? c.buttonInverse : c.buttonPrimary)
                  : (onDark
                        ? c.cardText.withValues(alpha: 0.45)
                        : c.borderDefault),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
        ],
      ],
    );
  }
}
