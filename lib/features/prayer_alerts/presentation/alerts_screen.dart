import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/di/home_ports.dart';
import '../../../core/design_system/design_system.dart';
import '../../../core/di/notification_providers.dart';
import '../../../core/platform/notification_types.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../home/domain/prayer_math.dart';
import '../domain/alert_settings.dart';
import 'alert_controller.dart';
import 'alert_text.dart';

/// Per-prayer alert mode, voice, lead time and pause. Home bells edit this too.
class PrayerAlertsScreen extends ConsumerWidget {
  const PrayerAlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final c = context.colors;
    final settings = ref.watch(alertSettingsProvider);
    final access = ref.watch(notificationAccessProvider);
    final times = ref.watch(todayTimesProvider);
    final osGranted = access.value == NotificationPermissionStatus.granted;
    final showNotice = access.hasValue && (!settings.enabled || !osGranted);
    final controller = ref.read(alertSettingsProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.space16,
            AppSpacing.space8,
            AppSpacing.space16,
            AppSpacing.space32,
          ),
          children: [
            Row(
              children: [
                AppIconButton(
                  icon: Icons.arrow_back_rounded,
                  semanticLabel: t.common.back,
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.home);
                    }
                  },
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: Text(
                    t.alerts.title,
                    style: AppTextStyles.uiHeadingMedium.copyWith(
                      color: c.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            if (showNotice) ...[
              const SizedBox(height: AppSpacing.space16),
              _Notice(
                text: t.alerts.offNotice,
                action: t.alerts.turnOn,
                onTurnOn: () => unawaited(controller.turnOn()),
              ),
            ],
            const SizedBox(height: AppSpacing.space24),
            AppSection(
              title: t.alerts.allFive,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.space12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ModePicker(
                        selected: settings.sharedMode,
                        onChanged: (mode) => unawaited(controller.setAll(mode)),
                      ),
                      if (settings.sharedMode case final mode?) ...[
                        const SizedBox(height: AppSpacing.space8),
                        Text(
                          modeHelp(t, mode),
                          style: AppTextStyles.uiCaptionRegular.copyWith(
                            color: c.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),
            AppSection(
              title: t.alerts.eachPrayer,
              children: [
                for (final id in prayers)
                  _PrayerAlertRow(
                    id: id,
                    settings: settings,
                    minutes: times?.minutesOf(id),
                    onMode: (mode) => unawaited(controller.setMode(id, mode)),
                    onOffset: (minutes) =>
                        unawaited(controller.setOffset(id, minutes)),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),
            AppSection(
              title: t.alerts.voice,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.space12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppSegmented<AdhanVoice>(
                        options: [
                          for (final voice in AdhanVoice.values)
                            AppSegmentOption(
                              value: voice,
                              label: voiceLabel(t, voice),
                            ),
                        ],
                        selected: settings.voice,
                        onChanged: (voice) =>
                            unawaited(controller.setVoice(voice)),
                      ),
                      const SizedBox(height: AppSpacing.space8),
                      Text(
                        t.alerts.adhanHelp,
                        style: AppTextStyles.uiCaptionRegular.copyWith(
                          color: c.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space24),
            AppSection(
              children: [
                AppRow(
                  title: t.alerts.pause,
                  subtitle: t.alerts.pauseHelp,
                  trailing: AppSwitch(
                    value: settings.promptsPaused,
                    onChanged: (value) =>
                        unawaited(controller.setPaused(value: value)),
                  ),
                ),
                AppRow(
                  title: t.alerts.jumuah,
                  subtitle: t.alerts.jumuahHelp,
                  trailing: AppSwitch(
                    value: settings.jumuahEarly,
                    onChanged: (value) =>
                        unawaited(controller.setJumuahEarly(value: value)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({
    required this.text,
    required this.action,
    required this.onTurnOn,
  });

  final String text;
  final String action;
  final VoidCallback onTurnOn;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.space12),
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
          AppButton(label: action, onPressed: onTurnOn),
        ],
      ),
    );
  }
}

class _PrayerAlertRow extends StatelessWidget {
  const _PrayerAlertRow({
    required this.id,
    required this.settings,
    required this.minutes,
    required this.onMode,
    required this.onOffset,
  });

  final PrayerId id;
  final PrayerAlertSettings settings;
  final int? minutes;
  final ValueChanged<AlertMode> onMode;
  final ValueChanged<int> onOffset;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    final offset = settings.offsetOf(id);
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _label(t),
                  style: AppTextStyles.uiBodyEmphasized.copyWith(
                    color: c.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Text(
                prayerArabic[id] ?? '',
                style: AppTextStyles.arabicLabel.copyWith(
                  color: c.accentDefault,
                ),
              ),
              if (minutes case final value?) ...[
                const SizedBox(width: AppSpacing.space12),
                Text(
                  fmtClock(value),
                  style: AppTextStyles.uiLabelRegular.copyWith(
                    color: c.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          _ModePicker(selected: settings.modeOf(id), onChanged: onMode),
          if (settings.modeOf(id) != AlertMode.off) ...[
            const SizedBox(height: AppSpacing.space8),
            _LeadPicker(minutesBefore: -offset, onChanged: onOffset),
          ],
        ],
      ),
    );
  }

  String _label(Translations t) => switch (id) {
    PrayerId.fajr => t.home.fajr,
    PrayerId.dhuhr => t.home.dhuhr,
    PrayerId.asr => t.home.asr,
    PrayerId.maghrib => t.home.maghrib,
    PrayerId.isha => t.home.isha,
  };
}

class _LeadPicker extends StatelessWidget {
  const _LeadPicker({required this.minutesBefore, required this.onChanged});

  final int minutesBefore;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    final current = leadLabel(t, minutesBefore);
    return LayoutBuilder(
      builder: (context, constraints) {
        return MenuAnchor(
          alignmentOffset: const Offset(0, AppSpacing.space4),
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(c.inputBackground),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            elevation: const WidgetStatePropertyAll(0),
            padding: const WidgetStatePropertyAll(
              EdgeInsetsDirectional.all(AppSpacing.space4),
            ),
            minimumSize: WidgetStatePropertyAll(Size(constraints.maxWidth, 0)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                side: BorderSide(
                  color: c.inputBorderDefault,
                  width: AppSizes.hairline,
                ),
              ),
            ),
          ),
          menuChildren: [
            for (final minutes in alertLeadMinutes)
              Semantics(
                selected: minutes == minutesBefore,
                child: MenuItemButton(
                  onPressed: () => onChanged(-minutes),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      minutes == minutesBefore
                          ? c.backgroundElevated
                          : Colors.transparent,
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(constraints.maxWidth, AppSizes.buttonHeightSmall),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.space12,
                      ),
                    ),
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppRadius.sm),
                        ),
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      leadLabel(t, minutes),
                      style: AppTextStyles.uiLabelRegular.copyWith(
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
          builder: (context, controller, child) {
            return Material(
              color: c.inputBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                side: BorderSide(
                  color: controller.isOpen
                      ? c.inputBorderFocus
                      : c.inputBorderDefault,
                  width: controller.isOpen
                      ? AppSizes.emphasisBorder
                      : AppSizes.hairline,
                ),
              ),
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                onTap: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: SizedBox(
                  height: AppSizes.buttonHeightSmall,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.space12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            t.alerts.lead,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.uiLabelRegular.copyWith(
                              color: c.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space8),
                        Text(
                          current,
                          style: AppTextStyles.uiLabelEmphasized.copyWith(
                            color: c.textPrimary,
                          ),
                        ),
                        Icon(
                          controller.isOpen
                              ? Icons.expand_less
                              : Icons.expand_more,
                          size: AppSizes.iconSizeSmall,
                          color: c.buttonIcon,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ModePicker extends StatelessWidget {
  const _ModePicker({required this.selected, required this.onChanged});

  final AlertMode? selected;
  final ValueChanged<AlertMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: context.colors.groupBackground,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          for (final mode in AlertMode.values)
            Expanded(
              child: _ModeOption(
                label: modeLabel(t, mode),
                selected: selected == mode,
                adhan: mode == AlertMode.adhan,
                onTap: () => onChanged(mode),
              ),
            ),
        ],
      ),
    );
  }
}

class _ModeOption extends StatelessWidget {
  const _ModeOption({
    required this.label,
    required this.selected,
    required this.adhan,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool adhan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final background = !selected
        ? Colors.transparent
        : (adhan ? c.buttonPrimary : c.segmentOn);
    final foreground = !selected
        ? c.textSecondary
        : (adhan ? c.textInverse : c.textPrimary);
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
        ),
        child: InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
          ),
          onTap: onTap,
          child: SizedBox(
            height: AppSizes.buttonHeightSmall,
            child: Center(
              child: Text(
                label,
                style: AppTextStyles.uiLabelEmphasized.copyWith(
                  color: foreground,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
