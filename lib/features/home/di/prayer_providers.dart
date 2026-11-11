import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/misc.dart';

import '../../../core/platform/flutter_timezone_service.dart';
import '../../../core/platform/geolocator_location_service.dart';
import '../../../core/storage/app_preferences.dart';
import '../data/adhan_prayer_times_calculator.dart';
import '../data/location_repository_impl.dart';
import '../data/prefs_location_store.dart';
import '../domain/repositories/prayer_times_calculator.dart';
import '../presentation/prayer_providers.dart';

/// Reads packaged JSON from disk. Widget tests share one platform channel,
/// and a message left pending by the first test blocks later asset loads.
final class _DiskAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) {
    final bytes = File(key).readAsBytesSync();
    return SynchronousFuture<ByteData>(
      ByteData.sublistView(Uint8List.fromList(bytes)),
    );
  }
}

AssetBundle _defaultBundle() {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return _DiskAssetBundle();
  }
  return rootBundle;
}

/// Binds prayer-time interfaces to their implementations.
List<Override> prayerFeatureOverrides({
  AssetBundle? bundle,
  PrayerTimesCalculator? calculator,
}) => [
  prayerTimesCalculatorProvider.overrideWithValue(
    calculator ?? const AdhanPrayerTimesCalculator(),
  ),
  locationRepositoryProvider.overrideWith((ref) {
    return LocationRepositoryImpl(
      location: const GeolocatorLocationService(),
      timeZone: const FlutterTimeZoneService(),
      store: PrefsLocationStore(ref.watch(appPreferencesProvider)),
      bundle: bundle ?? _defaultBundle(),
    );
  }),
];
