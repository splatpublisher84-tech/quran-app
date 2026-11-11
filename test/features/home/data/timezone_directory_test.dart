import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/home/data/timezone_directory_parser.dart';

void main() {
  test('every IANA zone and alias resolves to a coordinate', () {
    final raw = File('assets/data/timezones/zones.json').readAsStringSync();
    final directory = parseTimeZoneDirectory(raw);
    final missing = [
      for (final name in directory.names)
        if (directory.lookup(name) == null) name,
    ];
    expect(missing, isEmpty);
    expect(directory.lookup('Asia/Jakarta')?.countryCode, 'ID');
    expect(directory.lookup('Asia/Saigon')?.countryCode, 'VN');
    expect(directory.lookup('UTC'), isNotNull);
    expect(directory.lookup('GMT0'), isNotNull);
  });

  test('an unknown zone falls back to the UTC offset', () {
    final directory = parseTimeZoneDirectory(
      File('assets/data/timezones/zones.json').readAsStringSync(),
    );
    final place = directory.fallbackForOffset(const Duration(hours: 7));
    expect(place.longitude, closeTo(105, 0.1));
    expect(directory.lookup('Not/AZone'), isNull);
  });
}
