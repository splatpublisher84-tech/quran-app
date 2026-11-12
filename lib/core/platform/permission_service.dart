import 'location_types.dart';
import 'notification_types.dart';

/// Location and notification permission, without resolving a coordinate.
///
/// Prayer times still go through the location repository: that call stores
/// the fix. This service only answers the permission bit.
abstract interface class PermissionService {
  Future<LocationPermissionStatus> locationStatus();
  Future<LocationPermissionStatus> requestLocation();
  Future<NotificationPermissionStatus> notificationStatus();
  Future<NotificationPermissionStatus> requestNotification();
  Future<bool> openAppSettings();
}

/// Asks for notification permission, or opens app settings when the system
/// will not show the dialog again.
Future<NotificationPermissionStatus> turnOnNotificationPermission({
  required NotificationPermissionStatus current,
  required PermissionService permissions,
}) async {
  if (current == NotificationPermissionStatus.deniedForever) {
    await permissions.openAppSettings();
    return permissions.notificationStatus();
  }
  final after = await permissions.requestNotification();
  if (after != NotificationPermissionStatus.granted &&
      current == NotificationPermissionStatus.denied) {
    await permissions.openAppSettings();
    return permissions.notificationStatus();
  }
  return after;
}
