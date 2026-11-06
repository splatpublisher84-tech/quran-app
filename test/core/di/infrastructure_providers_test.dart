import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/di/infrastructure_providers.dart';
import 'package:quran_app/core/platform/clock.dart';

void main() {
  test('startup providers throw until overridden', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      () => container.read(appConfigProvider),
      throwsA(predicate((e) => e.toString().contains('overridden'))),
    );
    expect(
      () => container.read(sharedPreferencesProvider),
      throwsA(predicate((e) => e.toString().contains('overridden'))),
    );
  });

  test('clock defaults to the system clock and can be overridden', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(clockProvider), isA<SystemClock>());

    final fixed = _FixedClock(DateTime(2026, 11, 6, 13, 38));
    final overridden = ProviderContainer(
      overrides: [clockProvider.overrideWithValue(fixed)],
    );
    addTearDown(overridden.dispose);
    expect(overridden.read(clockProvider).now(), DateTime(2026, 11, 6, 13, 38));
  });

  test('dio is shared within a container', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(
      identical(container.read(dioProvider), container.read(dioProvider)),
      isTrue,
    );
  });
}

class _FixedClock implements AppClock {
  _FixedClock(this._now);

  final DateTime _now;

  @override
  DateTime now() => _now;
}
