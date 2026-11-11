import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/home/domain/hijri_calendar.dart';
import 'package:quran_app/features/home/domain/home_day.dart';
import 'package:quran_app/features/home/domain/prayer_math.dart';

DayTimes get _times => DayTimes(
  fajr: parseClock('04:22'),
  sunrise: parseClock('05:39'),
  dhuhr: parseClock('11:30'),
  asr: parseClock('14:50'),
  maghrib: parseClock('17:22'),
  isha: parseClock('18:35'),
);

HomeView _view({
  required int hour,
  required int minute,
  Set<PrayerId> prayed = const {},
  bool paused = false,
  HijriDate? hijri,
  HomePreview preview = HomePreview.live,
  DateTime? now,
  bool estimated = false,
  bool notificationsOff = false,
}) {
  final clock = now ?? DateTime(2026, 10, 27, hour, minute);
  return buildHomeView(
    now: clock,
    times: hijri?.isRamadan == true || preview == HomePreview.ramadan
        ? _times.withImsak()
        : _times,
    hijri: hijri ?? const HijriDate(year: 1448, month: 5, day: 15),
    prayed: prayed,
    paused: paused,
    locationEstimated: estimated,
    locationAction: LocationPromptAction.requestPermission,
    notificationsOff: notificationsOff,
    preview: preview,
    dayKey: '2026-10-27',
  );
}

void main() {
  test('prototype clocks map onto the six banners', () {
    expect(_view(hour: 13, minute: 38).status, isA<BannerStill>());
    expect(
      (_view(hour: 13, minute: 38).status as BannerStill).prayer,
      PrayerId.dhuhr,
    );

    final prayedDhuhr = _view(
      hour: 13,
      minute: 38,
      prayed: {PrayerId.dhuhr},
    ).status;
    expect(prayedDhuhr, isA<BannerPrayed>());
    expect((prayedDhuhr as BannerPrayed).next, PrayerId.asr);
    expect(prayedDhuhr.left, 72);

    final now = _view(hour: 14, minute: 58).status as BannerNow;
    expect(now.prayer, PrayerId.asr);

    final still = _view(hour: 15, minute: 40).status as BannerStill;
    expect(still.prayer, PrayerId.asr);
    expect(still.left, 102);

    final prayed =
        _view(hour: 15, minute: 42, prayed: {PrayerId.asr}).status
            as BannerPrayed;
    expect(prayed.prayer, PrayerId.asr);
    expect(prayed.next, PrayerId.maghrib);
    expect(prayed.left, 100);

    final night = _view(hour: 23, minute: 10).status as BannerNight;
    expect(night.left, 312);

    final paused = _view(hour: 14, minute: 58, paused: true).status;
    expect(paused, isA<BannerPaused>());
    expect((paused as BannerPaused).prayer, PrayerId.maghrib);
  });

  test('Friday names Dhuhr as Jumuah and offers Al-Kahf', () {
    final view = _view(
      hour: 11,
      minute: 0,
      now: DateTime(2026, 10, 30, 11),
      preview: HomePreview.friday,
    );
    expect(view.showJumuah, isTrue);
    expect(view.events.whereType<FridayEvent>(), isNotEmpty);
  });

  test('Ramadan counts down and suggests today juz', () {
    final view = _view(
      hour: 15,
      minute: 40,
      hijri: const HijriDate(year: 1447, month: 9, day: 11),
    );
    expect(view.fast?.kind, FastKind.fasting);
    expect(view.showPray, isTrue);
    expect(view.events.whereType<RamadanEvent>().single.juz, 11);
    expect(view.timeline.any((row) => row.kind == TimelineKind.imsak), isTrue);
  });

  test('the now banner wins over the Ramadan countdown', () {
    final view = _view(
      hour: 14,
      minute: 58,
      hijri: const HijriDate(year: 1447, month: 9, day: 11),
    );
    expect(view.status, isA<BannerNow>());
    expect(view.fast, isNull);
  });

  test('Eid greets and does not also show the Ramadan card', () {
    final view = _view(
      hour: 10,
      minute: 0,
      hijri: const HijriDate(year: 1447, month: 10, day: 1),
    );
    expect(view.events.single, isA<EidEvent>());
    expect((view.events.single as EidEvent).kind, EidKind.fitr);
  });

  test('notification strip wins over the location strip', () {
    final both = _view(
      hour: 7,
      minute: 0,
      estimated: true,
      notificationsOff: true,
    );
    expect(both.strip, HomeStrip.notificationsOff);
    final location = _view(hour: 7, minute: 0, estimated: true);
    expect(location.strip, HomeStrip.locationEstimated);
  });

  test('Hijri rolls at Maghrib and then applies the user offset', () {
    const maghrib = 17 * 60 + 22;
    final before = displayedHijri(
      civil: DateTime(2026, 6, 21),
      minuteOfDay: maghrib - 1,
      maghribMinute: maghrib,
      adjustment: 0,
    );
    final after = displayedHijri(
      civil: DateTime(2026, 6, 21),
      minuteOfDay: maghrib,
      maghribMinute: maghrib,
      adjustment: 0,
    );
    final shifted = displayedHijri(
      civil: DateTime(2026, 6, 21),
      minuteOfDay: maghrib,
      maghribMinute: maghrib,
      adjustment: -1,
    );
    expect(hijriToJdn(after), hijriToJdn(before) + 1);
    expect(shifted, before);
  });

  test('Umm al-Qura round-trips across 2026', () {
    var day = DateTime(2026, 1, 1);
    HijriDate? previous;
    for (var i = 0; i < 365; i++) {
      final hijri = hijriFromCivil(day.year, day.month, day.day);
      expect(hijri.month, inInclusiveRange(1, 12));
      expect(hijri.day, inInclusiveRange(1, 30));
      final back = hijriFromJdn(hijriToJdn(hijri));
      expect(back, hijri);
      if (previous != null) {
        expect(hijriToJdn(hijri), hijriToJdn(previous) + 1);
      }
      previous = hijri;
      day = day.add(const Duration(days: 1));
    }
  });
}
