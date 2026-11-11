import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/home/data/adhan_prayer_times_calculator.dart';
import 'package:quran_app/features/home/domain/calculation.dart';
import 'package:quran_app/features/home/domain/prayer_math.dart';

/// AlAdhan times for 21 June 2026, same coordinates and the official method
/// for each city. The wrapper must land within 2 minutes.
void main() {
  const calculator = AdhanPrayerTimesCalculator();
  final date = DateTime(2026, 6, 21);

  void expectNear(DayTimes actual, String expected) {
    final clocks = [
      actual.fajr,
      actual.sunrise,
      actual.dhuhr,
      actual.asr,
      actual.maghrib,
      actual.isha,
    ];
    final parts = expected.split(' ');
    for (var i = 0; i < clocks.length; i++) {
      final delta = (clocks[i] - parseClock(parts[i])).abs();
      expect(delta, lessThanOrEqualTo(2), reason: parts[i]);
    }
  }

  test('Jakarta Kemenag', () {
    expectNear(
      calculator.calculate(
        latitude: -6.1751,
        longitude: 106.865,
        civilDate: date,
        utcOffset: const Duration(hours: 7),
        method: CalculationMethodId.kemenag,
        asr: AsrMethod.standard,
        ramadan: false,
      ),
      '04:38 06:01 11:54 15:16 17:47 19:02',
    );
  });

  test('Karachi University of Islamic Sciences', () {
    expectNear(
      calculator.calculate(
        latitude: 24.8607,
        longitude: 67.0011,
        civilDate: date,
        utcOffset: const Duration(hours: 5),
        method: CalculationMethodId.karachi,
        asr: AsrMethod.standard,
        ramadan: false,
      ),
      '04:14 05:43 12:34 15:55 19:24 20:53',
    );
  });

  test('Cairo Egyptian General Authority', () {
    expectNear(
      calculator.calculate(
        latitude: 30.0444,
        longitude: 31.2357,
        civilDate: date,
        utcOffset: const Duration(hours: 3),
        method: CalculationMethodId.egyptian,
        asr: AsrMethod.standard,
        ramadan: false,
      ),
      '04:08 05:54 12:57 16:32 19:59 21:33',
    );
  });

  test('London Muslim World League', () {
    expectNear(
      calculator.calculate(
        latitude: 51.5074,
        longitude: -0.1278,
        civilDate: date,
        utcOffset: const Duration(hours: 1),
        method: CalculationMethodId.muslimWorldLeague,
        asr: AsrMethod.standard,
        ramadan: false,
      ),
      '02:31 04:43 13:02 17:25 21:22 23:27',
    );
  });

  test('New York ISNA', () {
    expectNear(
      calculator.calculate(
        latitude: 40.7128,
        longitude: -74.006,
        civilDate: date,
        utcOffset: const Duration(hours: -4),
        method: CalculationMethodId.northAmerica,
        asr: AsrMethod.standard,
        ramadan: false,
      ),
      '03:45 05:25 12:58 16:58 20:31 22:11',
    );
  });

  test('Umm al-Qura adds 30 minutes to Isha in Ramadan', () {
    DayTimes at({required bool ramadan}) => calculator.calculate(
      latitude: 21.4225,
      longitude: 39.8262,
      civilDate: date,
      utcOffset: const Duration(hours: 3),
      method: CalculationMethodId.ummAlQura,
      asr: AsrMethod.standard,
      ramadan: ramadan,
    );
    expect(at(ramadan: true).isha - at(ramadan: false).isha, 30);
  });

  test('Hanafi Asr is later than the standard Asr', () {
    DayTimes at(AsrMethod asr) => calculator.calculate(
      latitude: 24.8607,
      longitude: 67.0011,
      civilDate: date,
      utcOffset: const Duration(hours: 5),
      method: CalculationMethodId.karachi,
      asr: asr,
      ramadan: false,
    );
    expect(at(AsrMethod.hanafi).asr, greaterThan(at(AsrMethod.standard).asr));
  });
}
