import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/infrastructure_providers.dart';
import '../../core/storage/app_preferences.dart';
import '../../features/home/domain/calculation.dart';
import '../../features/home/domain/location.dart';
import '../../features/home/domain/prayer_math.dart';
import '../../features/home/domain/repositories/location_repository.dart';
import '../../features/home/domain/repositories/prayer_times_calculator.dart';
import '../../features/home/domain/usecases/location_use_cases.dart';

/// Cross-feature tokens for prayer times and location. Home owns the
/// implementations. Onboarding and prayer alerts watch the same instances.
final prayerTimesCalculatorProvider = Provider<PrayerTimesCalculator>(
  (ref) => throw UnimplementedError(
    'prayerTimesCalculatorProvider must be overridden',
  ),
);

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) =>
      throw UnimplementedError('locationRepositoryProvider must be overridden'),
);

final resolveUserLocationProvider = Provider<ResolveUserLocation>(
  (ref) => ResolveUserLocation(ref.watch(locationRepositoryProvider)),
);

final requestLocationPermissionProvider = Provider<RequestLocationPermission>(
  (ref) => RequestLocationPermission(ref.watch(locationRepositoryProvider)),
);

/// Cached until Home invalidates it on resume or after a permission change.
final locationSnapshotProvider = FutureProvider<LocationSnapshot>((ref) async {
  final result = await ref.watch(resolveUserLocationProvider).call();
  final value = result.valueOrNull;
  if (value == null) {
    throw StateError(result.failureOrNull?.message ?? 'Location failed');
  }
  return value;
});

/// Today's five prayer times, for the alerts screen and the onboarding preview.
final todayTimesProvider = Provider<DayTimes?>((ref) {
  final snapshot = ref.watch(locationSnapshotProvider).value;
  if (snapshot == null) return null;
  final now = ref.watch(clockProvider).now();
  final prefs = ref.watch(appPreferencesProvider);
  final method =
      calculationMethodFromCode(prefs.calculationMethodCode) ??
      methodForCountry(snapshot.location.countryCode);
  return ref
      .watch(prayerTimesCalculatorProvider)
      .calculate(
        latitude: snapshot.location.latitude,
        longitude: snapshot.location.longitude,
        civilDate: now,
        utcOffset: now.timeZoneOffset,
        method: method,
        asr: asrMethodFromCode(prefs.asrMethodCode),
        ramadan: false,
      );
});
