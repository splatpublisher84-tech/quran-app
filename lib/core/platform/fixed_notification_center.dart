import 'notification_types.dart';

/// In-memory notifications for tests and the dev panel.
final class FixedNotificationCenter implements LocalNotifications {
  FixedNotificationCenter({
    this.statusValue = NotificationPermissionStatus.granted,
  });

  NotificationPermissionStatus statusValue;
  List<PendingNotification> last = const [];

  @override
  Future<NotificationPermissionStatus> status() async => statusValue;

  @override
  Future<NotificationPermissionStatus> request() async => statusValue;

  @override
  Future<void> replaceAll(List<PendingNotification> pending) async {
    last = List<PendingNotification>.of(pending);
  }
}
