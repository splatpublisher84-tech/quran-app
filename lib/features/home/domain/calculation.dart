/// Calculation methods the app can name. Angles live in the adhan wrapper.
enum CalculationMethodId {
  muslimWorldLeague,
  ummAlQura,
  jakim,
  kemenag,
  egyptian,
  karachi,
  northAmerica,
  singapore,
  turkey,
  dubai,
  kuwait,
  qatar,
  moonsighting,
}

enum AsrMethod { standard, hanafi }

/// Above this absolute latitude, Fajr and Isha use the twilight-angle rule.
const double highLatitudeLimit = 48;

bool needsHighLatitude(double latitude) => latitude.abs() >= highLatitudeLimit;

/// Country default. Unknown and empty codes use Muslim World League.
/// JAKIM is Malaysia and Brunei. Kemenag is Indonesia. Both use 20 and 18.
CalculationMethodId methodForCountry(String? countryCode) {
  return switch (countryCode) {
    'SA' || 'BH' || 'YE' || 'OM' => CalculationMethodId.ummAlQura,
    'MY' || 'BN' => CalculationMethodId.jakim,
    'ID' => CalculationMethodId.kemenag,
    'SG' => CalculationMethodId.singapore,
    'PK' => CalculationMethodId.karachi,
    'EG' || 'SD' => CalculationMethodId.egyptian,
    'US' || 'CA' => CalculationMethodId.northAmerica,
    'TR' => CalculationMethodId.turkey,
    'AE' => CalculationMethodId.dubai,
    'KW' => CalculationMethodId.kuwait,
    'QA' => CalculationMethodId.qatar,
    _ => CalculationMethodId.muslimWorldLeague,
  };
}

class PrayerSettings {
  const PrayerSettings({
    this.methodOverride,
    this.asr = AsrMethod.standard,
    this.hijriAdjustment = 0,
    this.promptsPaused = false,
  });

  /// Null follows [methodForCountry].
  final CalculationMethodId? methodOverride;
  final AsrMethod asr;

  /// -1, 0 or 1. Applied after the Maghrib rollover.
  final int hijriAdjustment;
  final bool promptsPaused;

  int get clampedAdjustment => hijriAdjustment.clamp(-1, 1);

  PrayerSettings copyWith({
    CalculationMethodId? methodOverride,
    bool clearMethod = false,
    AsrMethod? asr,
    int? hijriAdjustment,
    bool? promptsPaused,
  }) {
    return PrayerSettings(
      methodOverride: clearMethod
          ? null
          : (methodOverride ?? this.methodOverride),
      asr: asr ?? this.asr,
      hijriAdjustment: hijriAdjustment ?? this.hijriAdjustment,
      promptsPaused: promptsPaused ?? this.promptsPaused,
    );
  }
}

CalculationMethodId? calculationMethodFromCode(String? code) {
  if (code == null) return null;
  for (final method in CalculationMethodId.values) {
    if (method.name == code) return method;
  }
  return null;
}

AsrMethod asrMethodFromCode(String? code) {
  for (final method in AsrMethod.values) {
    if (method.name == code) return method;
  }
  return AsrMethod.standard;
}
