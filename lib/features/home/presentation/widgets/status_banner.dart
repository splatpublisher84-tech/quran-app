import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../../i18n/strings.g.dart';
import '../../domain/home_day.dart';
import '../../domain/prayer_math.dart';
import '../prayer_labels.dart';

class StatusBanner extends StatelessWidget {
  const StatusBanner({
    required this.view,
    required this.onPray,
    required this.onPrayed,
    super.key,
  });

  final HomeView view;
  final VoidCallback onPray;
  final VoidCallback onPrayed;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    final fast = view.fast;
    final now = view.status is BannerNow;
    final still = view.status is BannerStill;
    final fasting = fast != null && !now;

    final Color background;
    final Color foreground;
    final Border? border;
    final Gradient? gradient;
    if (fasting) {
      background = Colors.transparent;
      foreground = c.cardText;
      border = null;
      gradient = c.cardGradient;
    } else if (now) {
      background = c.brandDefault;
      foreground = c.textInverse;
      border = null;
      gradient = null;
    } else if (still) {
      background = c.backgroundDefault;
      foreground = c.textPrimary;
      border = Border.all(
        color: c.accentDefault,
        width: AppSizes.emphasisBorder,
      );
      gradient = null;
    } else {
      background = c.groupBackground;
      foreground = c.textPrimary;
      border = null;
      gradient = null;
    }

    final captionColor = fasting
        ? foreground.withValues(alpha: 0.8)
        : (now ? foreground.withValues(alpha: 0.8) : c.accentDefault);
    final copy = _copy(t, view);

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.space16),
      decoration: BoxDecoration(
        color: gradient == null ? background : null,
        gradient: gradient,
        border: border,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            copy.caption.toUpperCase(),
            style: AppTextStyles.uiFootnoteUppercase.copyWith(
              color: captionColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      copy.title,
                      style: AppTextStyles.uiHeadingMedium.copyWith(
                        color: foreground,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      copy.subtitle,
                      style: AppTextStyles.uiLabelRegular.copyWith(
                        color: fasting || now
                            ? foreground.withValues(alpha: 0.8)
                            : c.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (copy.time case final time?)
                Text(
                  time,
                  style: AppTextStyles.uiHeadingMedium.copyWith(
                    color: foreground,
                  ),
                ),
            ],
          ),
          if (view.showPray) ...[
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                Expanded(
                  child: _BannerButton(
                    label: t.home.pray,
                    filled: true,
                    onLight: !now && !fasting,
                    onPressed: onPray,
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: _BannerButton(
                    label: t.home.ivePrayed,
                    filled: false,
                    onLight: !now && !fasting,
                    onPressed: onPrayed,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  _BannerCopy _copy(Translations t, HomeView view) {
    final jumuah = view.showJumuah;
    final fast = view.fast;
    if (fast != null && view.status is! BannerNow) {
      return switch (fast.kind) {
        FastKind.suhoor => _BannerCopy(
          caption: t.home.suhoorEnds,
          title: formatDuration(t, fast.left),
          subtitle: t.home.finishByImsak,
        ),
        FastKind.fasting => _BannerCopy(
          caption: t.home.fastingIftar,
          title: formatDuration(t, fast.left),
          subtitle: t.home.breakAtMaghrib,
        ),
        FastKind.night => _BannerCopy(
          caption: t.home.nextImsak,
          title: formatDuration(t, fast.left),
          subtitle: t.home.suhoorBeforeDawn,
        ),
      };
    }
    return switch (view.status) {
      BannerNow(:final prayer, :final start) => _BannerCopy(
        caption: t.home.itsTime,
        title: prayerLabel(t, prayer, jumuah: jumuah),
        subtitle: t.home.startedAt(time: fmtClock(start)),
      ),
      BannerStill(:final prayer, :final left) => _BannerCopy(
        caption: t.home.stillTime,
        title: prayerLabel(t, prayer, jumuah: jumuah),
        subtitle: t.home.timeLeft(duration: formatDuration(t, left)),
      ),
      BannerWaiting(:final prayer, :final start, :final left) => _BannerCopy(
        caption: t.home.nextPrayer,
        title: prayerLabel(t, prayer, jumuah: jumuah),
        subtitle: t.home.inDuration(duration: formatDuration(t, left)),
        time: fmtClock(start),
      ),
      BannerPrayed(:final prayer, :final left) => _BannerCopy(
        caption: t.home.prayed,
        title: prayerLabel(t, prayer, jumuah: jumuah),
        subtitle: t.home.nextIn(duration: formatDuration(t, left)),
      ),
      BannerNight(:final left, :final fajrStart) => _BannerCopy(
        caption: t.home.ishaEnded,
        title: prayerLabel(t, PrayerId.fajr, jumuah: false),
        subtitle: t.home.inDuration(duration: formatDuration(t, left)),
        time: fmtClock(fajrStart),
      ),
      BannerPaused(:final prayer, :final start) => _BannerCopy(
        caption: t.home.paused,
        title: prayerLabel(t, prayer, jumuah: jumuah),
        subtitle: t.home.promptsPaused,
        time: fmtClock(start),
      ),
    };
  }
}

class _BannerCopy {
  const _BannerCopy({
    required this.caption,
    required this.title,
    required this.subtitle,
    this.time,
  });

  final String caption;
  final String title;
  final String subtitle;
  final String? time;
}

class _BannerButton extends StatelessWidget {
  const _BannerButton({
    required this.label,
    required this.filled,
    required this.onLight,
    required this.onPressed,
  });

  final String label;
  final bool filled;
  final bool onLight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final background = filled
        ? (onLight ? c.buttonPrimary : c.buttonInverse)
        : Colors.transparent;
    final foreground = filled
        ? (onLight ? c.textInverse : c.brandDefault)
        : (onLight ? c.textPrimary : c.textInverse);
    final border = filled
        ? null
        : BorderSide(color: foreground.withValues(alpha: 0.4));

    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: background,
        shape: StadiumBorder(side: border ?? BorderSide.none),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onPressed,
          child: Container(
            height: AppSizes.iconButton,
            alignment: Alignment.center,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.space12,
            ),
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.uiButtonMedium.copyWith(color: foreground),
            ),
          ),
        ),
      ),
    );
  }
}
