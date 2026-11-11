import 'dart:math' as math;

import '../../../core/platform/location_types.dart';
import 'home_day.dart';

export '../../../core/platform/location_types.dart';

/// Where the coordinate used for prayer times came from.
enum LocationSource { gps, cached, timezone }

class UserLocation {
  const UserLocation({
    required this.latitude,
    required this.longitude,
    required this.source,
    required this.timeZoneId,
    this.countryCode,
  });

  final double latitude;
  final double longitude;
  final LocationSource source;
  final String timeZoneId;
  final String? countryCode;
}

class LocationSnapshot {
  const LocationSnapshot({required this.location, required this.permission});

  final UserLocation location;
  final LocationPermissionStatus permission;
}

/// Recalculate when a fresh fix moves at least this far. While-using only.
const double locationRefreshKm = 10;

double distanceKm(double lat1, double lon1, double lat2, double lon2) {
  const earthKm = 6371.0;
  double rad(double deg) => deg * math.pi / 180;
  final dLat = rad(lat2 - lat1);
  final dLon = rad(lon2 - lon1);
  final a =
      math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(rad(lat1)) *
          math.cos(rad(lat2)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  return 2 * earthKm * math.asin(math.sqrt(a));
}

/// What "Turn on" does for an estimated location. Service off wins over a
/// permanent denial, because the permission dialog cannot enable GPS.
LocationPromptAction promptFor(LocationPermissionStatus status) {
  return switch (status) {
    LocationPermissionStatus.serviceDisabled =>
      LocationPromptAction.openLocationSettings,
    LocationPermissionStatus.deniedForever =>
      LocationPromptAction.openAppSettings,
    _ => LocationPromptAction.requestPermission,
  };
}

class TimeZonePlace {
  const TimeZonePlace({
    required this.latitude,
    required this.longitude,
    this.countryCode,
  });

  final double latitude;
  final double longitude;
  final String? countryCode;
}

/// IANA zone to a coordinate. [fallbackForOffset] is the last resort when
/// the zone id is missing: longitude from the offset, latitude 25 so the
/// prayer angles stay away from the poles and the equator.
class TimeZoneDirectory {
  TimeZoneDirectory({required this._zones, required this._links});

  final Map<String, TimeZonePlace> _zones;
  final Map<String, String> _links;

  TimeZonePlace? lookup(String ianaId) {
    final seen = <String>{};
    var current = ianaId;
    while (seen.add(current)) {
      final place = _zones[current];
      if (place != null) return place;
      final link = _links[current];
      if (link == null) return null;
      current = link;
    }
    return null;
  }

  TimeZonePlace fallbackForOffset(Duration offset) {
    final hours = offset.inMinutes / 60.0;
    final longitude = (hours * 15).clamp(-180.0, 180.0);
    return TimeZonePlace(latitude: 25, longitude: longitude);
  }

  Iterable<String> get names => {..._zones.keys, ..._links.keys};
}
