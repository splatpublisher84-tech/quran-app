import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../../i18n/strings.g.dart';
import '../../domain/home_day.dart';
import '../../domain/prayer_math.dart';
import '../prayer_labels.dart';

class PrayerTimeline extends StatelessWidget {
  const PrayerTimeline({
    required this.view,
    required this.onBell,
    required this.onAllAlerts,
    super.key,
  });

  final HomeView view;
  final VoidCallback onBell;
  final VoidCallback onAllAlerts;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    return Column(
      children: [
        Stack(
          children: [
            PositionedDirectional(
              start: AppSizes.timelineRailStart,
              top: AppSpacing.space24,
              bottom: AppSpacing.space24,
              child: Container(
                width: AppSizes.timelineLineWidth,
                color: c.borderDefault,
              ),
            ),
            Column(
              children: [
                for (final entry in view.timeline)
                  _Row(
                    entry: entry,
                    jumuah: view.showJumuah,
                    nowMinute: minuteOfDay(view.now),
                    onBell: onBell,
                  ),
              ],
            ),
          ],
        ),
        TextButton(
          onPressed: onAllAlerts,
          child: Text(
            t.home.allAlerts,
            style: AppTextStyles.uiFootnote.copyWith(color: c.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.entry,
    required this.jumuah,
    required this.nowMinute,
    required this.onBell,
  });

  final TimelineEntry entry;
  final bool jumuah;
  final int nowMinute;
  final VoidCallback onBell;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    final state = entry.state;
    final current = state == RowState.current;
    final done = state == RowState.done;
    final past =
        state == RowState.past || (entry.minor && nowMinute >= entry.minutes);
    final nameColor = past || done ? c.textSecondary : c.textPrimary;
    final timeColor = current ? c.textPrimary : c.textSecondary;

    return Container(
      constraints: BoxConstraints(
        minHeight: entry.minor
            ? AppSizes.timelineMinorHeight
            : AppSizes.timelineRowHeight,
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: current ? c.brandSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.timelineTimeWidth,
            child: Text(
              fmtClock(entry.minutes),
              textAlign: TextAlign.end,
              style:
                  (current
                          ? AppTextStyles.uiLabelEmphasized
                          : AppTextStyles.uiFootnote)
                      .copyWith(color: timeColor),
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          _Node(state: state, minor: entry.minor),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: AppSpacing.space8,
              children: [
                Text(
                  _name(t),
                  style:
                      (entry.minor
                              ? AppTextStyles.uiLabelRegular
                              : AppTextStyles.uiBodyEmphasized)
                          .copyWith(color: nameColor),
                ),
                if (_arabic case final arabic?)
                  Text(
                    arabic,
                    style: AppTextStyles.arabicLabel.copyWith(
                      color: c.accentDefault,
                    ),
                  ),
                if (entry.iftar)
                  Text(
                    t.home.iftar,
                    style: AppTextStyles.uiFootnote.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          if (!entry.minor)
            IconButton(
              onPressed: onBell,
              icon: Icon(
                Icons.notifications_rounded,
                size: AppSizes.iconSizeSmall,
                color: c.textPrimary,
              ),
              style: IconButton.styleFrom(
                backgroundColor: current
                    ? c.backgroundSurface
                    : c.groupBackground,
                fixedSize: const Size(
                  AppSizes.timelineBell,
                  AppSizes.timelineBell,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _name(Translations t) {
    return switch (entry.kind) {
      TimelineKind.imsak => t.home.imsak,
      TimelineKind.sunrise => t.home.sunriseEnds,
      TimelineKind.fajr => t.home.fajr,
      TimelineKind.dhuhr => jumuah ? t.home.jumuah : t.home.dhuhr,
      TimelineKind.asr => t.home.asr,
      TimelineKind.maghrib => t.home.maghrib,
      TimelineKind.isha => t.home.isha,
    };
  }

  String? get _arabic => switch (entry.kind) {
    TimelineKind.fajr => prayerArabic[PrayerId.fajr],
    TimelineKind.dhuhr => prayerArabic[PrayerId.dhuhr],
    TimelineKind.asr => prayerArabic[PrayerId.asr],
    TimelineKind.maghrib => prayerArabic[PrayerId.maghrib],
    TimelineKind.isha => prayerArabic[PrayerId.isha],
    _ => null,
  };
}

class _Node extends StatelessWidget {
  const _Node({required this.state, required this.minor});

  final RowState? state;
  final bool minor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    if (minor) {
      return Container(
        width: AppSizes.timelineNodeMinor,
        height: AppSizes.timelineNodeMinor,
        decoration: BoxDecoration(
          color: c.borderDefault,
          shape: BoxShape.circle,
        ),
      );
    }
    final done = state == RowState.done;
    final current = state == RowState.current;
    final past = state == RowState.past;
    final size = done ? AppSizes.timelineNodeDone : AppSizes.timelineNode;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: done || current
            ? c.buttonPrimary
            : (past ? c.borderDefault : c.backgroundSurface),
        shape: BoxShape.circle,
        border: done || past
            ? null
            : Border.all(
                color: current ? c.buttonPrimary : c.borderDefault,
                width: AppSizes.timelineLineWidth,
              ),
        boxShadow: current
            ? [
                BoxShadow(
                  color: c.buttonPrimary.withValues(alpha: 0.22),
                  spreadRadius: AppSpacing.space4,
                ),
              ]
            : null,
      ),
      child: done
          ? Icon(Icons.check, size: AppSpacing.space12, color: c.textInverse)
          : null,
    );
  }
}
