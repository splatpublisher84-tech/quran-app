import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/home/domain/prayer_math.dart';

void main() {
  final times = DayTimes(
    fajr: parseClock('04:22'),
    sunrise: parseClock('05:39'),
    dhuhr: parseClock('11:30'),
    asr: parseClock('14:50'),
    maghrib: parseClock('17:22'),
    isha: parseClock('18:35'),
  );

  test('ends Isha at Islamic midnight, halfway from Maghrib to next Fajr', () {
    expect(getWindows(times).last.end, parseClock('22:52'));
  });

  group('getPrayerStatus', () {
    test('waits for the next prayer between windows', () {
      final status = getPrayerStatus(parseClock('07:00'), times, {});
      expect(status.kind, EngineKind.waiting);
      expect(status.prayer, PrayerId.dhuhr);
    });

    test('is now for the first 30 minutes', () {
      expect(
        getPrayerStatus(parseClock('14:50'), times, {}).kind,
        EngineKind.now,
      );
      expect(
        getPrayerStatus(parseClock('15:19'), times, {}).kind,
        EngineKind.now,
      );
    });

    test('becomes still until the window ends', () {
      final status = getPrayerStatus(parseClock('15:20'), times, {});
      expect(status.kind, EngineKind.still);
      expect(status.prayer, PrayerId.asr);
      expect(status.left, 122);
    });

    test('skips to the next prayer once prayed', () {
      final status = getPrayerStatus(parseClock('15:00'), times, {
        PrayerId.asr,
      });
      expect(status.kind, EngineKind.waiting);
      expect(status.prayer, PrayerId.maghrib);
      expect(status.left, 142);
    });

    test('goes to Dhuhr after Fajr ends at sunrise, even if not prayed', () {
      final status = getPrayerStatus(parseClock('05:39'), times, {});
      expect(status.kind, EngineKind.waiting);
      expect(status.prayer, PrayerId.dhuhr);
    });

    test('waits for tomorrow Fajr after Isha ends', () {
      final status = getPrayerStatus(parseClock('23:00'), times, {});
      expect(status.kind, EngineKind.waiting);
      expect(status.prayer, PrayerId.fajr);
      expect(status.start, parseClock('04:22'));
      expect(status.left, 322);
    });

    test('never prompts while prayer prompts are paused', () {
      final status = getPrayerStatus(
        parseClock('14:55'),
        times,
        {},
        paused: true,
      );
      expect(status.kind, EngineKind.waiting);
      expect(status.prayer, PrayerId.maghrib);
    });
  });

  test('marks each row by the clock and the prayed list', () {
    final now = parseClock('15:00');
    expect(getRowState(PrayerId.fajr, now, times, {}), RowState.past);
    expect(
      getRowState(PrayerId.dhuhr, now, times, {PrayerId.dhuhr}),
      RowState.done,
    );
    expect(getRowState(PrayerId.asr, now, times, {}), RowState.current);
    expect(getRowState(PrayerId.isha, now, times, {}), RowState.upcoming);
  });

  group('getFastStatus', () {
    final ramadan = DayTimes(
      fajr: times.fajr,
      sunrise: times.sunrise,
      dhuhr: times.dhuhr,
      asr: times.asr,
      maghrib: times.maghrib,
      isha: times.isha,
      imsak: parseClock('04:12'),
    );

    test('is null outside Ramadan', () {
      expect(getFastStatus(600, times), isNull);
    });

    test('counts to imsak, then iftar, then next imsak', () {
      expect(
        getFastStatus(parseClock('03:00'), ramadan)?.kind,
        FastKind.suhoor,
      );
      expect(getFastStatus(parseClock('03:00'), ramadan)?.left, 72);
      expect(
        getFastStatus(parseClock('15:00'), ramadan)?.kind,
        FastKind.fasting,
      );
      expect(getFastStatus(parseClock('15:00'), ramadan)?.left, 142);
      expect(getFastStatus(parseClock('20:00'), ramadan)?.kind, FastKind.night);
      expect(getFastStatus(parseClock('20:00'), ramadan)?.left, 492);
    });
  });

  test('fmtDuration drops zero parts', () {
    expect(fmtDuration(72), '1 h 12 min');
    expect(fmtDuration(45), '45 min');
    expect(fmtDuration(60), '1 h');
  });

  test('the prayed list resets at Fajr, not at midnight', () {
    final fajr = parseClock('04:22');
    final evening = DateTime(2026, 11, 10, 23, 10);
    final afterMidnight = DateTime(2026, 11, 11, 1, 0);
    final afterFajr = DateTime(2026, 11, 11, 4, 22);
    expect(prayerDayKey(evening, fajr), prayerDayKey(afterMidnight, fajr));
    expect(prayerDayKey(afterFajr, fajr), isNot(prayerDayKey(evening, fajr)));
  });
}
