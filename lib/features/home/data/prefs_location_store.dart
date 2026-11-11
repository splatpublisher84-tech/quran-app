import '../../../core/platform/location_types.dart';
import '../../../core/storage/app_preferences.dart';

final class PrefsLocationStore implements LocationStore {
  PrefsLocationStore(this._preferences);

  final AppPreferences _preferences;

  @override
  CachedLocation? read() {
    final raw = _preferences.locationCache;
    if (raw == null) return null;
    final parts = raw.split(',');
    if (parts.length != 2) return null;
    final latitude = double.tryParse(parts[0]);
    final longitude = double.tryParse(parts[1]);
    if (latitude == null || longitude == null) return null;
    return CachedLocation(latitude: latitude, longitude: longitude);
  }

  @override
  Future<void> save(CachedLocation location) {
    return _preferences.setLocationCache(
      '${location.latitude},${location.longitude}',
    );
  }
}
