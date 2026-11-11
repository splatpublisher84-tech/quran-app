/// Prayer windows and banner engine, ported from
/// `dev-handoff/03-prayer-logic` (`prayer.ts`). Pure Dart, no I/O.
library;

/// Minutes in a civil day.
const int dayMinutes = 24 * 60;

/// How long the "it's time" banner stays up after a prayer starts.
/// Remote config will own this in M10.
const int nowWindowMin = 30;

/// Imsak is this many minutes before Fajr during Ramadan.
const int imsakLeadMin = 10;

enum PrayerId { fajr, dhuhr, asr, maghrib, isha }

const List<PrayerId> prayers = PrayerId.values;

/// Minutes since local midnight. [imsak] is set only in Ramadan.
class DayTimes {
  const DayTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    this.imsak,
  });

  final int fajr;
  final int sunrise;
  final int dhuhr;
  final int asr;
  final int maghrib;
  final int isha;
  final int? imsak;

  int minutesOf(PrayerId id) => switch (id) {
    PrayerId.fajr => fajr,
    PrayerId.dhuhr => dhuhr,
    PrayerId.asr => asr,
    PrayerId.maghrib => maghrib,
    PrayerId.isha => isha,
  };

  DayTimes withImsak() => DayTimes(
    fajr: fajr,
    sunrise: sunrise,
    dhuhr: dhuhr,
    asr: asr,
    maghrib: maghrib,
    isha: isha,
    imsak: fajr >= imsakLeadMin
        ? fajr - imsakLeadMin
        : fajr - imsakLeadMin + dayMinutes,
  );
}

class PrayerWindow {
  const PrayerWindow({
    required this.id,
    required this.start,
    required this.end,
  });

  final PrayerId id;
  final int start;
  final int end;
}

enum EngineKind { now, still, waiting }

/// Result of [getPrayerStatus]. The Home banner maps this onto six UI states.
class EngineStatus {
  const EngineStatus({
    required this.kind,
    required this.prayer,
    required this.start,
    required this.left,
    this.end,
  });

  final EngineKind kind;
  final PrayerId prayer;
  final int start;
  final int left;
  final int? end;
}

enum RowState { done, current, past, upcoming }

enum FastKind { suhoor, fasting, night }

class FastStatus {
  const FastStatus({required this.kind, required this.left, required this.at});

  final FastKind kind;
  final int left;
  final int at;
}

/// Each prayer is valid until the next boundary. Isha ends at Islamic
/// midnight: halfway from Maghrib to the next Fajr.
List<PrayerWindow> getWindows(DayTimes times) {
  final islamicMidnight =
      times.maghrib + ((times.fajr + dayMinutes - times.maghrib) / 2).round();
  return [
    PrayerWindow(id: PrayerId.fajr, start: times.fajr, end: times.sunrise),
    PrayerWindow(id: PrayerId.dhuhr, start: times.dhuhr, end: times.asr),
    PrayerWindow(id: PrayerId.asr, start: times.asr, end: times.maghrib),
    PrayerWindow(id: PrayerId.maghrib, start: times.maghrib, end: times.isha),
    PrayerWindow(id: PrayerId.isha, start: times.isha, end: islamicMidnight),
  ];
}

EngineStatus getPrayerStatus(
  int now,
  DayTimes times,
  Set<PrayerId> prayed, {
  bool paused = false,
  int nowWindow = nowWindowMin,
}) {
  final windows = getWindows(times);
  final active = windows
      .where((w) => now >= w.start && now < w.end)
      .firstOrNull;
  if (active != null && !paused && !prayed.contains(active.id)) {
    return EngineStatus(
      kind: now - active.start < nowWindow ? EngineKind.now : EngineKind.still,
      prayer: active.id,
      start: active.start,
      end: active.end,
      left: active.end - now,
    );
  }
  final next = windows.where((w) => w.start > now).firstOrNull;
  final start = next != null ? next.start : times.fajr + dayMinutes;
  return EngineStatus(
    kind: EngineKind.waiting,
    prayer: next?.id ?? PrayerId.fajr,
    start: start % dayMinutes,
    left: start - now,
  );
}

RowState getRowState(
  PrayerId id,
  int now,
  DayTimes times,
  Set<PrayerId> prayed,
) {
  if (prayed.contains(id)) return RowState.done;
  final window = getWindows(times).firstWhere((w) => w.id == id);
  if (now >= window.end) return RowState.past;
  return now >= window.start ? RowState.current : RowState.upcoming;
}

/// Ramadan countdown. Null when [DayTimes.imsak] is absent.
FastStatus? getFastStatus(int now, DayTimes times) {
  final imsak = times.imsak;
  if (imsak == null) return null;
  if (now < imsak) {
    return FastStatus(kind: FastKind.suhoor, left: imsak - now, at: imsak);
  }
  if (now < times.maghrib) {
    return FastStatus(
      kind: FastKind.fasting,
      left: times.maghrib - now,
      at: times.maghrib,
    );
  }
  return FastStatus(
    kind: FastKind.night,
    left: imsak + dayMinutes - now,
    at: imsak,
  );
}

String fmtClock(int minute) {
  final m = ((minute % dayMinutes) + dayMinutes) % dayMinutes;
  final h = m ~/ 60;
  final min = m % 60;
  return '${h.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}';
}

/// English duration from the prototype. The UI localizes its own copy.
String fmtDuration(int minute) {
  final h = minute ~/ 60;
  final m = minute % 60;
  if (h == 0) return '$m min';
  return m == 0 ? '$h h' : '$h h $m min';
}

int parseClock(String value) {
  final parts = value.split(':');
  return int.parse(parts[0]) * 60 + int.parse(parts[1]);
}

int minuteOfDay(DateTime local) => local.hour * 60 + local.minute;

/// The prayed list resets at Fajr, not at midnight. Before today's Fajr the
/// key is yesterday, so a mark made after midnight still belongs to Isha.
String prayerDayKey(DateTime local, int fajrMinute) {
  final day = minuteOfDay(local) < fajrMinute
      ? local.subtract(const Duration(days: 1))
      : local;
  final y = day.year.toString().padLeft(4, '0');
  final m = day.month.toString().padLeft(2, '0');
  final d = day.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}
