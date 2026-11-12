/// Whether the app may post notifications.
enum NotificationPermissionStatus { unknown, granted, denied, deniedForever }

/// One pending local notification. The scheduler replaces the whole set.
class PendingNotification {
  const PendingNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.when,
    required this.channelId,
    required this.channelName,
    this.soundResource,
  });

  final int id;
  final String title;
  final String body;

  /// Local wall time.
  final DateTime when;

  /// Stable Android channel id. Versioned when the sound changes.
  final String channelId;
  final String channelName;

  /// Android raw resource name, without the extension. Null uses the default.
  final String? soundResource;
}

/// Posts and replaces the pending notification set.
abstract interface class NotificationScheduler {
  Future<void> replaceAll(List<PendingNotification> pending);
}

/// Reads and requests notification permission. No plugin types.
abstract interface class NotificationPermissions {
  Future<NotificationPermissionStatus> status();
  Future<NotificationPermissionStatus> request();
}

/// Both platform roles share one plugin instance.
abstract interface class LocalNotifications
    implements NotificationScheduler, NotificationPermissions {}
