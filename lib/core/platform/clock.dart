/// Source of the current time. Time and timezone come from the device only.
/// Tests and the dev debug panel override this provider.
abstract interface class AppClock {
  DateTime now();
}

final class SystemClock implements AppClock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();
}
