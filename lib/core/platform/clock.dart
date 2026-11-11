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

/// A clock the dev panel and tests can move.
final class FixedClock implements AppClock {
  FixedClock(this._now);

  DateTime _now;

  void set(DateTime value) => _now = value;

  @override
  DateTime now() => _now;
}
