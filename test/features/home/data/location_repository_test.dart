import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/home/data/location_repository_impl.dart';
import 'package:quran_app/features/home/domain/home_day.dart';
import 'package:quran_app/features/home/domain/location.dart';

class _Location implements LocationService {
  _Location({required this.permission, this.fix});

  LocationPermissionStatus permission;
  GeoFix? fix;
  int requests = 0;

  @override
  Future<LocationPermissionStatus> checkPermission() async => permission;

  @override
  Future<GeoFix?> currentFix() async => fix;

  @override
  Future<bool> openAppSettings() async => true;

  @override
  Future<bool> openLocationSettings() async => true;

  @override
  Future<LocationPermissionStatus> requestPermission() async {
    requests++;
    permission = LocationPermissionStatus.granted;
    return permission;
  }
}

class _Zones implements TimeZoneService {
  _Zones(this.id);

  final String id;

  @override
  Future<String> localIdentifier() async => id;

  @override
  Duration offsetAt(DateTime instant) => const Duration(hours: 7);
}

class _Store implements LocationStore {
  CachedLocation? cached;

  @override
  CachedLocation? read() => cached;

  @override
  Future<void> save(CachedLocation location) async => cached = location;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<LocationRepositoryImpl> repo(_Location location, _Store store) async {
    return LocationRepositoryImpl(
      location: location,
      timeZone: _Zones('Asia/Jakarta'),
      store: store,
      bundle: rootBundle,
    );
  }

  test('uses GPS and remembers a fix that moved', () async {
    final store = _Store();
    final location = _Location(
      permission: LocationPermissionStatus.granted,
      fix: const GeoFix(latitude: -6.2, longitude: 106.8),
    );
    final result = await (await repo(location, store)).resolve();
    final snapshot = result.valueOrNull!;
    expect(snapshot.location.source, LocationSource.gps);
    expect(snapshot.location.countryCode, 'ID');
    expect(store.cached?.latitude, -6.2);
  });

  test('keeps the stored fix when the new one is under 10 km', () async {
    final store = _Store()
      ..cached = const CachedLocation(latitude: -6.2, longitude: 106.8);
    final location = _Location(
      permission: LocationPermissionStatus.granted,
      fix: const GeoFix(latitude: -6.21, longitude: 106.81),
    );
    final result = await (await repo(location, store)).resolve();
    expect(result.valueOrNull!.location.latitude, -6.2);
    expect(result.valueOrNull!.location.source, LocationSource.gps);
  });

  test('uses the cache when GPS is allowed but the fix fails', () async {
    final store = _Store()
      ..cached = const CachedLocation(latitude: 1, longitude: 2);
    final location = _Location(permission: LocationPermissionStatus.granted);
    final result = await (await repo(location, store)).resolve();
    expect(result.valueOrNull!.location.source, LocationSource.cached);
    expect(result.valueOrNull!.location.latitude, 1);
  });

  test(
    'a denied permission estimates from the time zone and ignores cache',
    () async {
      final store = _Store()
        ..cached = const CachedLocation(latitude: 1, longitude: 2);
      final location = _Location(permission: LocationPermissionStatus.denied);
      final result = await (await repo(location, store)).resolve();
      final snapshot = result.valueOrNull!;
      expect(snapshot.location.source, LocationSource.timezone);
      expect(snapshot.location.countryCode, 'ID');
      expect(snapshot.location.latitude, isNot(1));
      expect(
        promptFor(snapshot.permission),
        LocationPromptAction.requestPermission,
      );
      expect(
        promptFor(LocationPermissionStatus.deniedForever),
        LocationPromptAction.openAppSettings,
      );
      expect(
        promptFor(LocationPermissionStatus.serviceDisabled),
        LocationPromptAction.openLocationSettings,
      );
    },
  );

  test('requesting permission asks the platform then resolves', () async {
    final store = _Store();
    final location = _Location(
      permission: LocationPermissionStatus.denied,
      fix: const GeoFix(latitude: -6.2, longitude: 106.8),
    );
    final result = await (await repo(location, store)).requestPermission();
    expect(location.requests, 1);
    expect(result.valueOrNull!.location.source, LocationSource.gps);
  });
}
