import 'package:adhan/adhan.dart' as adhan;

import '../domain/calculation.dart';
import '../domain/prayer_math.dart';
import '../domain/repositories/prayer_times_calculator.dart';

/// Adhan wrapper. JAKIM and Kemenag both use fajr 20 and isha 18, which the
/// library exposes as the Singapore parameters (including the +1 minute
/// Dhuhr adjustment). Umm al-Qura adds 30 minutes to Isha in Ramadan.
final class AdhanPrayerTimesCalculator implements PrayerTimesCalculator {
  const AdhanPrayerTimesCalculator();

  @override
  DayTimes calculate({
    required double latitude,
    required double longitude,
    required DateTime civilDate,
    required Duration utcOffset,
    required CalculationMethodId method,
    required AsrMethod asr,
    required bool ramadan,
  }) {
    final params = _parameters(method);
    params.madhab = switch (asr) {
      AsrMethod.standard => adhan.Madhab.shafi,
      AsrMethod.hanafi => adhan.Madhab.hanafi,
    };
    if (needsHighLatitude(latitude)) {
      params.highLatitudeRule = adhan.HighLatitudeRule.twilight_angle;
    }
    if (ramadan && method == CalculationMethodId.ummAlQura) {
      params.adjustments.isha += 30;
    }
    final times = adhan.PrayerTimes.utcOffset(
      adhan.Coordinates(latitude, longitude),
      adhan.DateComponents(civilDate.year, civilDate.month, civilDate.day),
      params,
      utcOffset,
    );
    return DayTimes(
      fajr: _minute(times.fajr),
      sunrise: _minute(times.sunrise),
      dhuhr: _minute(times.dhuhr),
      asr: _minute(times.asr),
      maghrib: _minute(times.maghrib),
      isha: _minute(times.isha),
    );
  }

  adhan.CalculationParameters _parameters(CalculationMethodId method) {
    final library = switch (method) {
      CalculationMethodId.muslimWorldLeague =>
        adhan.CalculationMethod.muslim_world_league,
      CalculationMethodId.ummAlQura => adhan.CalculationMethod.umm_al_qura,
      CalculationMethodId.jakim ||
      CalculationMethodId.kemenag ||
      CalculationMethodId.singapore => adhan.CalculationMethod.singapore,
      CalculationMethodId.egyptian => adhan.CalculationMethod.egyptian,
      CalculationMethodId.karachi => adhan.CalculationMethod.karachi,
      CalculationMethodId.northAmerica => adhan.CalculationMethod.north_america,
      CalculationMethodId.turkey => adhan.CalculationMethod.turkey,
      CalculationMethodId.dubai => adhan.CalculationMethod.dubai,
      CalculationMethodId.kuwait => adhan.CalculationMethod.kuwait,
      CalculationMethodId.qatar => adhan.CalculationMethod.qatar,
      CalculationMethodId.moonsighting =>
        adhan.CalculationMethod.moon_sighting_committee,
    };
    return library.getParameters();
  }

  int _minute(DateTime time) => time.hour * 60 + time.minute;
}
