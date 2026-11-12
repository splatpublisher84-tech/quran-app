import 'location_types.dart';
import 'notification_types.dart';
import 'permission_service.dart';

/// Delegates each permission to the platform service that already owns it.
final class PlatformPermissionService implements PermissionService {
  const PlatformPermissionService({
    required this._location,
    required this._notifications,
  });

  final LocationService _location;
  final NotificationPermissions _notifications;

  @override
  Future<LocationPermissionStatus> locationStatus() =>
      _location.checkPermission();

  @override
  Future<LocationPermissionStatus> requestLocation() =>
      _location.requestPermission();

  @override
  Future<NotificationPermissionStatus> notificationStatus() =>
      _notifications.status();

  @override
  Future<NotificationPermissionStatus> requestNotification() =>
      _notifications.request();

  @override
  Future<bool> openAppSettings() => _location.openAppSettings();
}
