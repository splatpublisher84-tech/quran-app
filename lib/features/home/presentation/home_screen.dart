import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/design_system/design_system.dart';
import '../../../core/di/infrastructure_providers.dart';
import '../../../core/di/notification_providers.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../domain/home_day.dart';
import '../domain/prayer_math.dart';
import 'home_controller.dart';
import 'prayer_labels.dart';
import 'prayer_providers.dart';
import 'widgets/prayer_timeline.dart';
import 'widgets/status_banner.dart';

/// Prayer times for today: banner, events, and the five-prayer timeline.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(homeProvider.notifier).refreshLocation();
      ref.invalidate(notificationAccessProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);
    final dev = ref.watch(appConfigProvider).isDev;
    return Scaffold(
      body: SafeArea(
        child: home.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) =>
              _HomeError(onRetry: () => ref.invalidate(homeProvider)),
          data: (view) => _HomeBody(view: view, showDebug: dev),
        ),
      ),
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.t.home.loadError,
              textAlign: TextAlign.center,
              style: AppTextStyles.uiBodyRegular.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            AppButton(
              label: context.t.common.retry,
              onPressed: onRetry,
              variant: AppButtonVariant.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.view, required this.showDebug});

  final HomeView view;
  final bool showDebug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space24,
      ),
      children: [
        AppLargeHeader(title: t.tabs.home),
        const SizedBox(height: AppSpacing.space8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: formatCivilDate(t, view.now),
                style: AppTextStyles.uiLabelRegular.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              TextSpan(
                text: ' · ',
                style: AppTextStyles.uiLabelRegular.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              TextSpan(
                text: formatHijri(t, view.hijri.month, view.hijri.day),
                style: AppTextStyles.uiLabelEmphasized.copyWith(
                  color: context.colors.accentDefault,
                ),
              ),
            ],
          ),
        ),
        if (view.strip != null) ...[
          const SizedBox(height: AppSpacing.space12),
          _Strip(
            text: view.strip == HomeStrip.notificationsOff
                ? t.home.alertsOff
                : t.home.estimatedTimes,
            onTurnOn: () {
              final notifier = ref.read(homeProvider.notifier);
              if (view.strip == HomeStrip.notificationsOff) {
                unawaited(notifier.turnOnNotifications());
              } else if (view.strip == HomeStrip.locationEstimated) {
                unawaited(notifier.turnOnLocation());
              }
            },
          ),
        ],
        const SizedBox(height: AppSpacing.space12),
        StatusBanner(
          view: view,
          onPray: () => showAppToast(context, t.home.prayLater),
          onPrayed: () => unawaited(_markPrayed(context, ref, view)),
        ),
        for (final event in view.events) ...[
          const SizedBox(height: AppSpacing.space12),
          _EventCard(event: event, onTap: () => _openEvent(context, event)),
        ],
        const SizedBox(height: AppSpacing.space8),
        PrayerTimeline(
          view: view,
          alerts: ref.watch(displayedAlertSettingsProvider),
          notificationsGranted: view.strip != HomeStrip.notificationsOff,
          onBell: (_) => context.push(AppRoutes.prayerAlerts),
          onAllAlerts: () => context.push(AppRoutes.prayerAlerts),
        ),
        if (showDebug) ...[
          const SizedBox(height: AppSpacing.space16),
          const _DebugPanel(),
        ],
      ],
    );
  }

  Future<void> _markPrayed(
    BuildContext context,
    WidgetRef ref,
    HomeView view,
  ) async {
    final id = view.markable;
    if (id == null) return;
    final name = prayerLabel(context.t, id, jumuah: view.showJumuah);
    final previous = await ref.read(homeProvider.notifier).markPrayed();
    if (!context.mounted || previous == null) return;
    showAppToast(
      context,
      context.t.home.marked(name: name),
      actionLabel: context.t.home.undo,
      onAction: () {
        unawaited(ref.read(homeProvider.notifier).restorePrayed(previous));
      },
    );
  }

  void _openEvent(BuildContext context, HomeEvent event) {
    switch (event) {
      case FridayEvent():
        context.go(AppRoutes.quranSurah(18));
      case RamadanEvent(:final juz):
        context.go(AppRoutes.quranJuz(juz));
      case EidEvent():
        showAppToast(context, context.t.quran.shareLater);
    }
  }
}

class _Strip extends StatelessWidget {
  const _Strip({required this.text, required this.onTurnOn});

  final String text;
  final VoidCallback onTurnOn;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.space16,
        AppSpacing.space8,
        AppSpacing.space8,
        AppSpacing.space8,
      ),
      decoration: BoxDecoration(
        color: c.brandSoft,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.uiLabelRegular.copyWith(
                color: c.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          AppButton(
            label: context.t.home.turnOn,
            onPressed: onTurnOn,
            variant: AppButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.onTap});

  final HomeEvent event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    final (title, subtitle, icon) = switch (event) {
      FridayEvent() => (
        t.home.readKahf,
        t.home.fridayTradition,
        Icons.menu_book_rounded,
      ),
      RamadanEvent(:final juz) => (
        t.home.juzToday(n: juz),
        t.home.ramadanReading,
        Icons.auto_stories_rounded,
      ),
      EidEvent() => (
        t.home.eidMubarak,
        t.home.shareEid,
        Icons.celebration_rounded,
      ),
    };
    return Material(
      color: c.backgroundDefault,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: c.borderDefault),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.space16,
            AppSpacing.space12,
            AppSpacing.space12,
            AppSpacing.space12,
          ),
          child: Row(
            children: [
              Icon(icon, color: c.accentDefault, size: AppSizes.iconSize),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.uiBodyEmphasized.copyWith(
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      subtitle,
                      style: AppTextStyles.uiFootnote.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DebugPanel extends ConsumerWidget {
  const _DebugPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final c = context.colors;
    final debug = ref.watch(debugSessionProvider);
    final settings = ref.watch(prayerSettingsProvider);
    final shown = debug.clock ?? ref.watch(clockProvider).now();
    final minute = minuteOfDay(shown);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.home.debugClock,
          style: AppTextStyles.uiLabelEmphasized.copyWith(color: c.textPrimary),
        ),
        Text(
          fmtClock(minute),
          style: AppTextStyles.uiBodyRegular.copyWith(color: c.textSecondary),
        ),
        Slider(
          value: minute.toDouble(),
          max: (dayMinutes - 1).toDouble(),
          onChanged: (value) =>
              ref.read(debugSessionProvider.notifier).setMinute(value.round()),
        ),
        Row(
          children: [
            AppButton(
              label: t.home.debugEarlier,
              variant: AppButtonVariant.secondary,
              onPressed: () =>
                  ref.read(debugSessionProvider.notifier).shiftDays(-1),
            ),
            const SizedBox(width: AppSpacing.space8),
            AppButton(
              label: t.home.debugLater,
              variant: AppButtonVariant.secondary,
              onPressed: () =>
                  ref.read(debugSessionProvider.notifier).shiftDays(1),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space8),
        AppButton(
          label: t.home.debugDevice,
          variant: AppButtonVariant.text,
          onPressed: () =>
              ref.read(debugSessionProvider.notifier).useDeviceClock(),
        ),
        const SizedBox(height: AppSpacing.space8),
        AppSegmented<HomePreview>(
          options: [
            AppSegmentOption(
              value: HomePreview.live,
              label: t.home.previewLive,
            ),
            AppSegmentOption(
              value: HomePreview.friday,
              label: t.home.previewFriday,
            ),
            AppSegmentOption(
              value: HomePreview.ramadan,
              label: t.home.previewRamadan,
            ),
            AppSegmentOption(value: HomePreview.eid, label: t.home.previewEid),
          ],
          selected: debug.preview,
          onChanged: ref.read(debugSessionProvider.notifier).setPreview,
        ),
        const SizedBox(height: AppSpacing.space8),
        Row(
          children: [
            Expanded(
              child: Text(
                t.home.promptsPaused,
                style: AppTextStyles.uiLabelRegular.copyWith(
                  color: c.textPrimary,
                ),
              ),
            ),
            AppSwitch(
              value: settings.promptsPaused,
              onChanged: (value) {
                unawaited(
                  ref
                      .read(prayerSettingsProvider.notifier)
                      .setPromptsPaused(value: value),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
