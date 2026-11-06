# Logic giờ salah

Created: 2026-11-06 · Last modified: 2026-11-06

> Sinh tự động từ `prototype/src/domain/prayer.ts`, `prayer.test.ts`, `scenarios.ts` bằng `npm run export:handoff` trong `prototype/`. Không sửa tay: sửa file nguồn rồi chạy lại.

Port nguyên logic và test sang Dart. Bảng tóm tắt nằm ở handoff mục 4.2.

## prayer.ts

```ts
export const PRAYERS = ["fajr", "dhuhr", "asr", "maghrib", "isha"] as const;
export type PrayerId = (typeof PRAYERS)[number];

/** Minutes since local midnight. */
export type DayTimes = Record<PrayerId | "sunrise", number> & { imsak?: number };

export type PrayerWindow = { id: PrayerId; start: number; end: number };

export type PrayerStatus =
  | { kind: "now" | "still"; prayer: PrayerId; start: number; end: number; left: number }
  | { kind: "waiting"; prayer: PrayerId; start: number; left: number };

export type FastStatus = { kind: "suhoor" | "fasting" | "night"; left: number; at: number };

export type RowState = "done" | "current" | "past" | "upcoming";

/** Banner stays prominent this long after a prayer starts. Remote config in the real app. */
export const NOW_WINDOW_MIN = 30;

const DAY = 24 * 60;

/** Each prayer is valid until the next boundary. Isha ends at Islamic midnight: halfway from Maghrib to next Fajr. */
export function getWindows(t: DayTimes): PrayerWindow[] {
  const islamicMidnight = t.maghrib + Math.round((t.fajr + DAY - t.maghrib) / 2);
  return [
    { id: "fajr", start: t.fajr, end: t.sunrise },
    { id: "dhuhr", start: t.dhuhr, end: t.asr },
    { id: "asr", start: t.asr, end: t.maghrib },
    { id: "maghrib", start: t.maghrib, end: t.isha },
    { id: "isha", start: t.isha, end: islamicMidnight },
  ];
}

export function getPrayerStatus(
  now: number,
  times: DayTimes,
  prayed: readonly PrayerId[],
  opts: { paused?: boolean; nowWindow?: number } = {},
): PrayerStatus {
  const { paused = false, nowWindow = NOW_WINDOW_MIN } = opts;
  const windows = getWindows(times);
  const active = windows.find((w) => now >= w.start && now < w.end);
  if (active && !paused && !prayed.includes(active.id)) {
    const { id: prayer, start, end } = active;
    return { kind: now - start < nowWindow ? "now" : "still", prayer, start, end, left: end - now };
  }
  const next = windows.find((w) => w.start > now);
  const start = next ? next.start : times.fajr + DAY;
  return { kind: "waiting", prayer: next ? next.id : "fajr", start: start % DAY, left: start - now };
}

export function getRowState(id: PrayerId, now: number, times: DayTimes, prayed: readonly PrayerId[]): RowState {
  if (prayed.includes(id)) return "done";
  const w = getWindows(times).find((x) => x.id === id)!;
  if (now >= w.end) return "past";
  return now >= w.start ? "current" : "upcoming";
}

/** Ramadan countdown: to end of suhoor before dawn, to iftar during the day, to next suhoor at night. */
export function getFastStatus(now: number, times: DayTimes): FastStatus | null {
  if (times.imsak == null) return null;
  if (now < times.imsak) return { kind: "suhoor", left: times.imsak - now, at: times.imsak };
  if (now < times.maghrib) return { kind: "fasting", left: times.maghrib - now, at: times.maghrib };
  return { kind: "night", left: times.imsak + DAY - now, at: times.imsak };
}

export function fmtClock(min: number): string {
  const m = ((min % DAY) + DAY) % DAY;
  return `${String(Math.floor(m / 60)).padStart(2, "0")}:${String(m % 60).padStart(2, "0")}`;
}

export function fmtDuration(min: number): string {
  const h = Math.floor(min / 60);
  const m = min % 60;
  if (!h) return `${m} min`;
  return m ? `${h} h ${m} min` : `${h} h`;
}

export function parseClock(s: string): number {
  const [h, m] = s.split(":").map(Number);
  return h * 60 + m;
}
```

## prayer.test.ts

Các case bắt buộc phải pass. Giờ mẫu: Fajr 04:22, Sunrise 05:39, Dhuhr 11:30, Asr 14:50, Maghrib 17:22, Isha 18:35.

```ts
import { describe, expect, it } from "vitest";
import { fmtDuration, getFastStatus, getPrayerStatus, getRowState, getWindows, parseClock as c, type DayTimes } from "./prayer";

const times: DayTimes = { fajr: c("04:22"), sunrise: c("05:39"), dhuhr: c("11:30"), asr: c("14:50"), maghrib: c("17:22"), isha: c("18:35") };

describe("getWindows", () => {
  it("ends Isha at Islamic midnight, halfway from Maghrib to next Fajr", () => {
    expect(getWindows(times).at(-1)!.end).toBe(c("22:52"));
  });
});

describe("getPrayerStatus", () => {
  it("waits for the next prayer between windows", () => {
    expect(getPrayerStatus(c("07:00"), times, [])).toMatchObject({ kind: "waiting", prayer: "dhuhr" });
  });
  it("is 'now' for the first 30 minutes", () => {
    expect(getPrayerStatus(c("14:50"), times, [])).toMatchObject({ kind: "now", prayer: "asr" });
    expect(getPrayerStatus(c("15:19"), times, [])).toMatchObject({ kind: "now" });
  });
  it("becomes 'still' until the window ends", () => {
    expect(getPrayerStatus(c("15:20"), times, [])).toMatchObject({ kind: "still", prayer: "asr", left: 122 });
  });
  it("skips to the next prayer once prayed", () => {
    expect(getPrayerStatus(c("15:00"), times, ["asr"])).toMatchObject({ kind: "waiting", prayer: "maghrib", left: 142 });
  });
  it("goes to Dhuhr after Fajr ends at sunrise, even if not prayed", () => {
    expect(getPrayerStatus(c("05:39"), times, [])).toMatchObject({ kind: "waiting", prayer: "dhuhr" });
  });
  it("waits for tomorrow's Fajr after Isha ends", () => {
    expect(getPrayerStatus(c("23:00"), times, [])).toMatchObject({ kind: "waiting", prayer: "fajr", start: c("04:22"), left: 322 });
  });
  it("never prompts while prayer prompts are paused", () => {
    expect(getPrayerStatus(c("14:55"), times, [], { paused: true })).toMatchObject({ kind: "waiting", prayer: "maghrib" });
  });
});

describe("getRowState", () => {
  it("marks each row by the clock and the prayed list", () => {
    expect(getRowState("fajr", c("15:00"), times, [])).toBe("past");
    expect(getRowState("dhuhr", c("15:00"), times, ["dhuhr"])).toBe("done");
    expect(getRowState("asr", c("15:00"), times, [])).toBe("current");
    expect(getRowState("isha", c("15:00"), times, [])).toBe("upcoming");
  });
});

describe("getFastStatus", () => {
  const ramadan = { ...times, imsak: c("04:12") };
  it("is null outside Ramadan", () => expect(getFastStatus(600, times)).toBeNull());
  it("counts to imsak, then iftar, then next imsak", () => {
    expect(getFastStatus(c("03:00"), ramadan)).toMatchObject({ kind: "suhoor", left: 72 });
    expect(getFastStatus(c("15:00"), ramadan)).toMatchObject({ kind: "fasting", left: 142 });
    expect(getFastStatus(c("20:00"), ramadan)).toMatchObject({ kind: "night", left: 492 });
  });
});

describe("fmtDuration", () => {
  it("drops zero parts", () => {
    expect(fmtDuration(72)).toBe("1 h 12 min");
    expect(fmtDuration(45)).toBe("45 min");
    expect(fmtDuration(60)).toBe("1 h");
  });
});
```

## scenarios.ts

Dữ liệu giả cho ngày thường, thứ Sáu, Ramadan, Eid. App thật tính giờ bằng thư viện; file này chỉ để biết prototype đang mô phỏng gì.

```ts
import { parseClock as c, type DayTimes } from "./prayer";
import type { AyahRef } from "./quran";

export type ScenarioId = "normal" | "friday" | "ramadan" | "eid";
export type AsrMethod = "standard" | "hanafi";

export type Scenario = {
  id: ScenarioId;
  label: string;
  date: string;
  hijri: { day: number; month: string; year: number };
  times: DayTimes;
  isFriday?: boolean;
  isRamadan?: boolean;
  /** Suggested Juz to read today in Ramadan: one Juz a day finishes the Quran in the month. */
  juzToday?: number;
  greeting?: string;
  ayahs: [AyahRef, AyahRef, AyahRef];
};

const base: DayTimes = { fajr: c("04:22"), sunrise: c("05:39"), dhuhr: c("11:30"), asr: c("14:50"), maghrib: c("17:22"), isha: c("18:35") };

// Sample data for review. In the real app times come from the calculation library, ayahs from a reviewed list.
export const SCENARIOS: Record<ScenarioId, Scenario> = {
  normal: {
    id: "normal", label: "Ngày thường", date: "Tue, 27 Oct",
    hijri: { day: 15, month: "Jumada al-Ula", year: 1448 }, times: base,
    ayahs: [{ surah: 94, ayah: 6 }, { surah: 2, ayah: 152 }, { surah: 55, ayah: 13 }],
  },
  friday: {
    id: "friday", label: "Thứ Sáu", date: "Fri, 30 Oct", isFriday: true,
    hijri: { day: 18, month: "Jumada al-Ula", year: 1448 }, times: base,
    ayahs: [{ surah: 18, ayah: 10 }, { surah: 94, ayah: 5 }, { surah: 3, ayah: 139 }],
  },
  ramadan: {
    id: "ramadan", label: "Ramadan", date: "Thu, 18 Feb", isRamadan: true, juzToday: 11,
    hijri: { day: 11, month: "Ramadan", year: 1448 },
    times: { imsak: c("04:30"), fajr: c("04:40"), sunrise: c("05:58"), dhuhr: c("11:55"), asr: c("15:14"), maghrib: c("17:52"), isha: c("19:02") },
    ayahs: [{ surah: 2, ayah: 183 }, { surah: 2, ayah: 186 }, { surah: 97, ayah: 1 }],
  },
  eid: {
    id: "eid", label: "Eid al-Fitr", date: "Wed, 10 Mar", greeting: "Eid Mubarak",
    hijri: { day: 1, month: "Shawwal", year: 1448 },
    times: { fajr: c("04:30"), sunrise: c("05:46"), dhuhr: c("11:52"), asr: c("15:12"), maghrib: c("17:58"), isha: c("19:08") },
    ayahs: [{ surah: 2, ayah: 185 }, { surah: 13, ayah: 28 }, { surah: 55, ayah: 13 }],
  },
};

export const TOMORROW_AYAHS: [AyahRef, AyahRef, AyahRef] = [{ surah: 13, ayah: 28 }, { surah: 3, ayah: 139 }, { surah: 29, ayah: 69 }];

/** Small fake offsets so changing a setting visibly changes the timeline. */
const CALC_OFFSET: Record<string, Partial<Record<keyof DayTimes, number>>> = {
  mwl: {},
  umm: { fajr: -6, isha: 22 },
  jakim: { fajr: 4, isha: 3 },
};

export function resolveTimes(s: Scenario, asr: AsrMethod, calc: string): DayTimes {
  const t = { ...s.times };
  for (const [k, v] of Object.entries(CALC_OFFSET[calc] ?? {})) t[k as keyof DayTimes]! += v;
  if (asr === "hanafi") t.asr += 62;
  return t;
}

export function hijriLabel(s: Scenario, now: number, maghrib: number, adjust: number): string {
  // The Islamic day starts at sunset, so the Hijri date turns over at Maghrib.
  const day = s.hijri.day + adjust + (now >= maghrib ? 1 : 0);
  return `${day} ${s.hijri.month}`;
}
```
