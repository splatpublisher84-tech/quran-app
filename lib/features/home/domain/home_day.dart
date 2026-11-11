import 'hijri_calendar.dart';
import 'prayer_math.dart';

/// Six Home banners. [getPrayerStatus] stays the three-kind engine. This
/// layer is what the screen renders.
sealed class BannerStatus {
  const BannerStatus();
}

class BannerWaiting extends BannerStatus {
  const BannerWaiting({
    required this.prayer,
    required this.start,
    required this.left,
  });

  final PrayerId prayer;
  final int start;
  final int left;
}

class BannerNow extends BannerStatus {
  const BannerNow({
    required this.prayer,
    required this.start,
    required this.end,
    required this.left,
  });

  final PrayerId prayer;
  final int start;
  final int end;
  final int left;
}

class BannerStill extends BannerStatus {
  const BannerStill({
    required this.prayer,
    required this.start,
    required this.end,
    required this.left,
  });

  final PrayerId prayer;
  final int start;
  final int end;
  final int left;
}

/// The current window's prayer was marked. The next prayer is [next].
class BannerPrayed extends BannerStatus {
  const BannerPrayed({
    required this.prayer,
    required this.next,
    required this.nextStart,
    required this.left,
  });

  final PrayerId prayer;
  final PrayerId next;
  final int nextStart;
  final int left;
}

/// After Isha's window, until Fajr.
class BannerNight extends BannerStatus {
  const BannerNight({required this.fajrStart, required this.left});

  final int fajrStart;
  final int left;
}

class BannerPaused extends BannerStatus {
  const BannerPaused({
    required this.prayer,
    required this.start,
    required this.left,
  });

  final PrayerId prayer;
  final int start;
  final int left;
}

BannerStatus resolveBanner({
  required int now,
  required DayTimes times,
  required Set<PrayerId> prayed,
  required bool paused,
}) {
  final engine = getPrayerStatus(now, times, prayed, paused: paused);
  if (paused) {
    return BannerPaused(
      prayer: engine.prayer,
      start: engine.start,
      left: engine.left,
    );
  }
  switch (engine.kind) {
    case EngineKind.now:
      return BannerNow(
        prayer: engine.prayer,
        start: engine.start,
        end: engine.end!,
        left: engine.left,
      );
    case EngineKind.still:
      return BannerStill(
        prayer: engine.prayer,
        start: engine.start,
        end: engine.end!,
        left: engine.left,
      );
    case EngineKind.waiting:
      final windows = getWindows(times);
      final active = windows
          .where((w) => now >= w.start && now < w.end)
          .firstOrNull;
      if (active != null && prayed.contains(active.id)) {
        return BannerPrayed(
          prayer: active.id,
          next: engine.prayer,
          nextStart: engine.start,
          left: engine.left,
        );
      }
      if (engine.prayer == PrayerId.fajr && _isNight(now, times, windows)) {
        return BannerNight(fajrStart: engine.start, left: engine.left);
      }
      return BannerWaiting(
        prayer: engine.prayer,
        start: engine.start,
        left: engine.left,
      );
  }
}

bool _isNight(int now, DayTimes times, List<PrayerWindow> windows) {
  if (now < times.fajr) return true;
  final ishaEnd = windows.last.end;
  return ishaEnd <= dayMinutes && now >= ishaEnd;
}

/// Prayer the "I've prayed" button can mark, when one is in its window.
PrayerId? markablePrayer(BannerStatus status) => switch (status) {
  BannerNow(:final prayer) => prayer,
  BannerStill(:final prayer) => prayer,
  _ => null,
};

enum HomePreview { live, friday, ramadan, eid }

enum HomeStrip { notificationsOff, locationEstimated }

/// Notification strip wins when both would show. M4 sets [notificationsOff].
HomeStrip? homeStrip({
  required bool notificationsOff,
  required bool locationEstimated,
}) {
  if (notificationsOff) return HomeStrip.notificationsOff;
  if (locationEstimated) return HomeStrip.locationEstimated;
  return null;
}

enum LocationPromptAction {
  requestPermission,
  openAppSettings,
  openLocationSettings,
}

enum TimelineKind { imsak, fajr, sunrise, dhuhr, asr, maghrib, isha }

class TimelineEntry {
  const TimelineEntry({
    required this.kind,
    required this.minutes,
    required this.minor,
    this.state,
    this.iftar = false,
  });

  final TimelineKind kind;
  final int minutes;
  final bool minor;
  final RowState? state;
  final bool iftar;
}

sealed class HomeEvent {
  const HomeEvent();
}

class FridayEvent extends HomeEvent {
  const FridayEvent();
}

class RamadanEvent extends HomeEvent {
  const RamadanEvent(this.juz);

  /// One juz a day. Clamped to 1..30.
  final int juz;
}

enum EidKind { fitr, adha }

class EidEvent extends HomeEvent {
  const EidEvent(this.kind);

  final EidKind kind;
}

class HomeView {
  const HomeView({
    required this.now,
    required this.times,
    required this.hijri,
    required this.status,
    required this.fast,
    required this.showPray,
    required this.markable,
    required this.timeline,
    required this.events,
    required this.strip,
    required this.locationAction,
    required this.showJumuah,
    required this.prayed,
    required this.dayKey,
  });

  final DateTime now;
  final DayTimes times;
  final HijriDate hijri;
  final BannerStatus status;
  final FastStatus? fast;
  final bool showPray;
  final PrayerId? markable;
  final List<TimelineEntry> timeline;
  final List<HomeEvent> events;
  final HomeStrip? strip;
  final LocationPromptAction? locationAction;
  final bool showJumuah;
  final Set<PrayerId> prayed;
  final String dayKey;
}

HomeView buildHomeView({
  required DateTime now,
  required DayTimes times,
  required HijriDate hijri,
  required Set<PrayerId> prayed,
  required bool paused,
  required bool locationEstimated,
  required LocationPromptAction? locationAction,
  required bool notificationsOff,
  required HomePreview preview,
  required String dayKey,
}) {
  final minute = minuteOfDay(now);
  final status = resolveBanner(
    now: minute,
    times: times,
    prayed: prayed,
    paused: paused,
  );
  final ramadan = preview == HomePreview.ramadan || hijri.isRamadan;
  final fast = ramadan && status is! BannerNow
      ? getFastStatus(minute, times.imsak == null ? times.withImsak() : times)
      : null;
  final showPray = status is BannerNow || status is BannerStill;
  final friday =
      preview == HomePreview.friday || now.weekday == DateTime.friday;
  final events = <HomeEvent>[];
  if (preview == HomePreview.eid ||
      (preview == HomePreview.live &&
          (hijri.isEidAlFitr || hijri.isEidAlAdha))) {
    events.add(EidEvent(hijri.isEidAlAdha ? EidKind.adha : EidKind.fitr));
  } else if (ramadan && preview != HomePreview.friday) {
    final day = hijri.day.clamp(1, 30);
    events.add(RamadanEvent(day));
  }
  if (friday) events.add(const FridayEvent());

  return HomeView(
    now: now,
    times: times,
    hijri: hijri,
    status: status,
    fast: fast,
    showPray: (showPray && fast == null) || status is BannerStill,
    markable: markablePrayer(status),
    timeline: _timeline(minute, times, prayed, ramadan: ramadan),
    events: events,
    strip: homeStrip(
      notificationsOff: notificationsOff,
      locationEstimated: locationEstimated,
    ),
    locationAction: locationEstimated ? locationAction : null,
    showJumuah: friday,
    prayed: prayed,
    dayKey: dayKey,
  );
}

List<TimelineEntry> _timeline(
  int now,
  DayTimes times,
  Set<PrayerId> prayed, {
  required bool ramadan,
}) {
  final entries = <TimelineEntry>[];
  final imsak = ramadan
      ? (times.imsak ?? times.withImsak().imsak)
      : times.imsak;
  if (imsak != null) {
    entries.add(
      TimelineEntry(kind: TimelineKind.imsak, minutes: imsak, minor: true),
    );
  }
  for (final id in prayers) {
    if (id == PrayerId.fajr) {
      entries.add(
        TimelineEntry(
          kind: TimelineKind.fajr,
          minutes: times.fajr,
          minor: false,
          state: getRowState(id, now, times, prayed),
        ),
      );
      entries.add(
        TimelineEntry(
          kind: TimelineKind.sunrise,
          minutes: times.sunrise,
          minor: true,
        ),
      );
      continue;
    }
    entries.add(
      TimelineEntry(
        kind: switch (id) {
          PrayerId.fajr => TimelineKind.fajr,
          PrayerId.dhuhr => TimelineKind.dhuhr,
          PrayerId.asr => TimelineKind.asr,
          PrayerId.maghrib => TimelineKind.maghrib,
          PrayerId.isha => TimelineKind.isha,
        },
        minutes: times.minutesOf(id),
        minor: false,
        state: getRowState(id, now, times, prayed),
        iftar: ramadan && id == PrayerId.maghrib,
      ),
    );
  }
  return entries;
}
