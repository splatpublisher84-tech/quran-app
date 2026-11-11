// Builds assets/data/timezones/zones.json from the IANA zone tables.
//
// Inputs (public domain, checked in so the script runs offline):
//   tool/data/zone1970.tab
//   tool/data/backward
//
// Run when the IANA tables change:
//   dart run tool/build_timezone_asset.dart
import 'dart:convert';
import 'dart:io';

const _zoneTab = 'tool/data/zone1970.tab';
const _backward = 'tool/data/backward';
const _out = 'assets/data/timezones/zones.json';

/// Aliases of UTC. zone1970.tab does not list them; they resolve to the
/// prime meridian so a device reporting "UTC" still gets a coordinate.
const _utcAliases = [
  'Etc/GMT+0',
  'Etc/GMT-0',
  'Etc/GMT0',
  'Etc/Greenwich',
  'Etc/UCT',
  'Etc/Universal',
  'Etc/Zulu',
  'GMT+0',
  'GMT-0',
  'GMT0',
  'Greenwich',
  'UCT',
  'UTC',
  'Universal',
  'Zulu',
];

void main() {
  final zones = <String, List<Object>>{};
  for (final line in File(_zoneTab).readAsLinesSync()) {
    if (line.isEmpty || line.startsWith('#')) continue;
    final parts = line.split('\t');
    final country = parts[0].split(',').first;
    final coord = _parseCoord(parts[1]);
    zones[parts[2]] = [coord.$1, coord.$2, country];
  }
  // Prime meridian. Etc/GMT is the target of the old GMT aliases.
  zones['Etc/UTC'] = [0.0, 0.0];
  zones['Etc/GMT'] = [0.0, 0.0];

  final links = <String, String>{};
  for (final line in File(_backward).readAsLinesSync()) {
    if (!line.startsWith('Link')) continue;
    final parts = line.split(RegExp(r'\s+'));
    if (parts.length < 3) continue;
    links[parts[2]] = parts[1];
  }
  for (final alias in _utcAliases) {
    links.putIfAbsent(alias, () => 'Etc/UTC');
  }

  final file = File(_out);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(jsonEncode({'zones': zones, 'links': links}));
  stdout.writeln('Wrote ${zones.length} zones and ${links.length} links.');
}

(double, double) _parseCoord(String raw) {
  final match = RegExp(
    r'^([+-])(\d{2})(\d{2})(\d{2})?([+-])(\d{3})(\d{2})(\d{2})?$',
  ).firstMatch(raw);
  if (match == null) {
    throw FormatException('Bad coordinate $raw');
  }
  double dec(String sign, String deg, String min, String? sec) {
    final value =
        int.parse(deg) +
        int.parse(min) / 60 +
        (sec == null ? 0 : int.parse(sec) / 3600);
    return sign == '-' ? -value : value;
  }

  final lat = dec(match[1]!, match[2]!, match[3]!, match[4]);
  final lon = dec(match[5]!, match[6]!, match[7]!, match[8]);
  return (
    double.parse(lat.toStringAsFixed(4)),
    double.parse(lon.toStringAsFixed(4)),
  );
}
