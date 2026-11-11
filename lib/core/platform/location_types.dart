/// Permission and a low-accuracy fix. No Flutter, no plugin types.
enum LocationPermissionStatus {
  unknown,
  granted,
  denied,
  deniedForever,
  serviceDisabled,
}

class GeoFix {
  const GeoFix({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

/// Last GPS fix kept on the device. Used when a new fix fails, not when
/// permission is denied (that path estimates from the time zone).
class CachedLocation {
  const CachedLocation({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

abstract interface class LocationService {
  Future<LocationPermissionStatus> checkPermission();
  Future<LocationPermissionStatus> requestPermission();
  Future<GeoFix?> currentFix();
  Future<bool> openAppSettings();
  Future<bool> openLocationSettings();
}

abstract interface class TimeZoneService {
  /// IANA id when the platform has one, otherwise a short name.
  Future<String> localIdentifier();

  Duration offsetAt(DateTime instant);
}

abstract interface class LocationStore {
  CachedLocation? read();
  Future<void> save(CachedLocation location);
}
