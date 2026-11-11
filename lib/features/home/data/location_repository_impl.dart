import 'package:flutter/services.dart';

import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../domain/location.dart';
import '../domain/repositories/location_repository.dart';
import 'timezone_directory_parser.dart';

const timezoneAsset = 'assets/data/timezones/zones.json';

/// GPS when permission is granted, the last fix when a new reading fails,
/// otherwise a coordinate for the device time zone.
final class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required this._location,
    required this._timeZone,
    required this._store,
    required this._bundle,
  });

  final LocationService _location;
  final TimeZoneService _timeZone;
  final LocationStore _store;
  final AssetBundle _bundle;

  TimeZoneDirectory? _directory;

  @override
  Future<Result<LocationSnapshot>> resolve() => _resolve(request: false);

  @override
  Future<Result<LocationSnapshot>> requestPermission() =>
      _resolve(request: true);

  @override
  Future<Result<bool>> openAppSettings() async {
    try {
      return Ok(await _location.openAppSettings());
    } on Object catch (e) {
      return Err(PlatformFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> openLocationSettings() async {
    try {
      return Ok(await _location.openLocationSettings());
    } on Object catch (e) {
      return Err(PlatformFailure(e.toString()));
    }
  }

  Future<Result<LocationSnapshot>> _resolve({required bool request}) async {
    try {
      final directory = await _loadDirectory();
      final zoneId = await _timeZone.localIdentifier();
      final permission = request
          ? await _location.requestPermission()
          : await _location.checkPermission();
      final place = directory.lookup(zoneId);
      final country = place?.countryCode;

      if (permission == LocationPermissionStatus.granted) {
        final fix = await _location.currentFix();
        if (fix != null) {
          final cached = _store.read();
          final moved =
              cached == null ||
              distanceKm(
                    cached.latitude,
                    cached.longitude,
                    fix.latitude,
                    fix.longitude,
                  ) >=
                  locationRefreshKm;
          final latitude = moved ? fix.latitude : cached.latitude;
          final longitude = moved ? fix.longitude : cached.longitude;
          if (moved) {
            await _store.save(
              CachedLocation(latitude: latitude, longitude: longitude),
            );
          }
          return Ok(
            _snapshot(
              latitude: latitude,
              longitude: longitude,
              source: LocationSource.gps,
              zoneId: zoneId,
              country: country,
              permission: permission,
            ),
          );
        }
        final cached = _store.read();
        if (cached != null) {
          return Ok(
            _snapshot(
              latitude: cached.latitude,
              longitude: cached.longitude,
              source: LocationSource.cached,
              zoneId: zoneId,
              country: country,
              permission: permission,
            ),
          );
        }
      }

      final estimated =
          place ??
          directory.fallbackForOffset(_timeZone.offsetAt(DateTime.now()));
      return Ok(
        _snapshot(
          latitude: estimated.latitude,
          longitude: estimated.longitude,
          source: LocationSource.timezone,
          zoneId: zoneId,
          country: estimated.countryCode ?? country,
          permission: permission,
        ),
      );
    } on Object catch (e) {
      return Err(UnknownFailure(e.toString()));
    }
  }

  Future<TimeZoneDirectory> _loadDirectory() async {
    final cached = _directory;
    if (cached != null) return cached;
    final raw = await _bundle.loadString(timezoneAsset);
    return _directory = parseTimeZoneDirectory(raw);
  }

  LocationSnapshot _snapshot({
    required double latitude,
    required double longitude,
    required LocationSource source,
    required String zoneId,
    required String? country,
    required LocationPermissionStatus permission,
  }) {
    return LocationSnapshot(
      location: UserLocation(
        latitude: latitude,
        longitude: longitude,
        source: source,
        timeZoneId: zoneId,
        countryCode: country,
      ),
      permission: permission,
    );
  }
}
