import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../platform/geolocator_location_service.dart';
import '../platform/local_notification_center.dart';
import '../platform/notification_types.dart';
import '../platform/permission_service.dart';
import '../platform/platform_permission_service.dart';

final localNotificationsProvider = Provider<LocalNotifications>(
  (ref) => LocalNotificationCenter(),
);

final notificationSchedulerProvider = Provider<NotificationScheduler>(
  (ref) => ref.watch(localNotificationsProvider),
);

final notificationPermissionsProvider = Provider<NotificationPermissions>(
  (ref) => ref.watch(localNotificationsProvider),
);

final permissionServiceProvider = Provider<PermissionService>(
  (ref) => PlatformPermissionService(
    location: const GeolocatorLocationService(),
    notifications: ref.watch(notificationPermissionsProvider),
  ),
);

final notificationAccessProvider = FutureProvider<NotificationPermissionStatus>(
  (ref) {
    return ref.watch(notificationPermissionsProvider).status();
  },
);
