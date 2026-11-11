import 'dart:async';
import 'dart:io';

import 'package:flutter_timezone/flutter_timezone.dart';

import 'location_types.dart';

const _platformWait = Duration(seconds: 3);

/// `flutter test` sets this. A plugin call that never replies blocks every
/// later platform message, including asset loads in the next test.
bool get _underTest => Platform.environment.containsKey('FLUTTER_TEST');

Future<T> _bound<T>(Future<T> future) {
  unawaited(future.then<void>((_) {}, onError: (Object _) {}));
  return future.timeout(_platformWait);
}

final class FlutterTimeZoneService implements TimeZoneService {
  const FlutterTimeZoneService();

  @override
  Future<String> localIdentifier() async {
    if (_underTest) return 'UTC';
    try {
      final info = await _bound(FlutterTimezone.getLocalTimezone());
      if (info.identifier.isNotEmpty) return info.identifier;
    } on Object {
      // Plugin missing, or the platform returned nothing.
    }
    return DateTime.now().timeZoneName;
  }

  @override
  Duration offsetAt(DateTime instant) => instant.timeZoneOffset;
}
