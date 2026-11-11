import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';

import 'location_types.dart';

const _platformWait = Duration(seconds: 3);

bool get _underTest => Platform.environment.containsKey('FLUTTER_TEST');

/// Completes even when the plugin channel never replies. A late platform
/// error is swallowed so it is not reported twice.
Future<T> _bound<T>(Future<T> future) {
  unawaited(future.then<void>((_) {}, onError: (Object _) {}));
  return future.timeout(_platformWait);
}

/// Low-accuracy, while-in-use location. Failures become a denied status or a
/// null fix so prayer times can fall back to the time zone.
final class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService();

  @override
  Future<LocationPermissionStatus> checkPermission() async {
    if (_underTest) return LocationPermissionStatus.denied;
    try {
      final enabled = await _bound(Geolocator.isLocationServiceEnabled());
      if (!enabled) return LocationPermissionStatus.serviceDisabled;
      return _map(await _bound(Geolocator.checkPermission()));
    } on Object {
      return LocationPermissionStatus.denied;
    }
  }

  @override
  Future<LocationPermissionStatus> requestPermission() async {
    if (_underTest) return LocationPermissionStatus.denied;
    try {
      final enabled = await _bound(Geolocator.isLocationServiceEnabled());
      if (!enabled) return LocationPermissionStatus.serviceDisabled;
      return _map(await _bound(Geolocator.requestPermission()));
    } on Object {
      return LocationPermissionStatus.denied;
    }
  }

  @override
  Future<GeoFix?> currentFix() async {
    if (_underTest) return null;
    try {
      final position = await _bound(
        Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.low,
            timeLimit: _platformWait,
          ),
        ),
      );
      return GeoFix(latitude: position.latitude, longitude: position.longitude);
    } on Object {
      return null;
    }
  }

  @override
  Future<bool> openAppSettings() async {
    try {
      return await Geolocator.openAppSettings();
    } on Object {
      return false;
    }
  }

  @override
  Future<bool> openLocationSettings() async {
    try {
      return await Geolocator.openLocationSettings();
    } on Object {
      return false;
    }
  }

  LocationPermissionStatus _map(LocationPermission permission) {
    return switch (permission) {
      LocationPermission.always ||
      LocationPermission.whileInUse => LocationPermissionStatus.granted,
      LocationPermission.denied => LocationPermissionStatus.denied,
      LocationPermission.deniedForever =>
        LocationPermissionStatus.deniedForever,
      LocationPermission.unableToDetermine => LocationPermissionStatus.unknown,
    };
  }
}
