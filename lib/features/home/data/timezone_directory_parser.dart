import 'dart:convert';

import '../domain/location.dart';

/// Parses the asset written by `tool/build_timezone_asset.dart`.
TimeZoneDirectory parseTimeZoneDirectory(String raw) {
  final json = jsonDecode(raw) as Map<String, dynamic>;
  final zonesRaw = json['zones'] as Map<String, dynamic>;
  final linksRaw = json['links'] as Map<String, dynamic>;
  final zones = <String, TimeZonePlace>{};
  for (final entry in zonesRaw.entries) {
    final list = entry.value as List<dynamic>;
    final country = list.length > 2 ? list[2] as String? : null;
    zones[entry.key] = TimeZonePlace(
      latitude: (list[0] as num).toDouble(),
      longitude: (list[1] as num).toDouble(),
      countryCode: (country == null || country.isEmpty) ? null : country,
    );
  }
  return TimeZoneDirectory(
    zones: zones,
    links: {
      for (final entry in linksRaw.entries) entry.key: entry.value as String,
    },
  );
}
