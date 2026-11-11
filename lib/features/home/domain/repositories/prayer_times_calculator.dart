import '../calculation.dart';
import '../prayer_math.dart';

/// Wraps the adhan library. High latitude uses the twilight-angle rule.
abstract interface class PrayerTimesCalculator {
  DayTimes calculate({
    required double latitude,
    required double longitude,
    required DateTime civilDate,
    required Duration utcOffset,
    required CalculationMethodId method,
    required AsrMethod asr,
    required bool ramadan,
  });
}
