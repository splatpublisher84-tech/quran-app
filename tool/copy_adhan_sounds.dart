// Copies assets/audio/adhan/*.wav into the Android raw resources and the
// iOS Runner folder.
//
// Each file must be PCM 16-bit mono, 44.1 kHz, at most 5.0 seconds.
// Fade the last 0.3 seconds out before adding a file. If the folder is
// empty, notifications keep the system default sound.
//
//   dart run tool/copy_adhan_sounds.dart
import 'dart:io';

const _source = 'assets/audio/adhan';
const _androidRaw = 'android/app/src/main/res/raw';
const _iosRunner = 'ios/Runner';

void main() {
  final dir = Directory(_source);
  if (!dir.existsSync()) {
    stdout.writeln(
      'No $_source directory. Notifications use the default sound.',
    );
    return;
  }
  final wavs = dir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.toLowerCase().endsWith('.wav'))
      .toList();
  if (wavs.isEmpty) {
    stdout.writeln(
      'No wav files in $_source. Notifications use the default sound.',
    );
    return;
  }
  Directory(_androidRaw).createSync(recursive: true);
  for (final file in wavs) {
    final name = file.uri.pathSegments.last;
    final error = wavProblem(file.readAsBytesSync());
    if (error != null) {
      stderr.writeln('$name skipped: $error');
      continue;
    }
    final rawName = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9._]'), '_');
    file.copySync('$_androidRaw/$rawName');
    file.copySync('$_iosRunner/$name');
    stdout.writeln('Copied $name');
  }
}

/// Null when [bytes] is a short PCM 16-bit mono 44.1 kHz wav.
String? wavProblem(List<int> bytes) {
  if (bytes.length < 44) return 'too small to be a wav';
  final riff = String.fromCharCodes(bytes.sublist(0, 4));
  final wave = String.fromCharCodes(bytes.sublist(8, 12));
  if (riff != 'RIFF' || wave != 'WAVE') return 'not a wav';
  var offset = 12;
  int? channels;
  int? rate;
  int? bits;
  int? dataBytes;
  while (offset + 8 <= bytes.length) {
    final id = String.fromCharCodes(bytes.sublist(offset, offset + 4));
    final size = _le32(bytes, offset + 4);
    final start = offset + 8;
    if (start + size > bytes.length) return 'truncated chunk';
    if (id == 'fmt ' && size >= 16) {
      final format = _le16(bytes, start);
      channels = _le16(bytes, start + 2);
      rate = _le32(bytes, start + 4);
      bits = _le16(bytes, start + 14);
      if (format != 1) return 'not PCM';
    } else if (id == 'data') {
      dataBytes = size;
    }
    offset = start + size + (size.isOdd ? 1 : 0);
  }
  if (channels != 1) return 'must be mono';
  if (rate != 44100) return 'must be 44.1 kHz';
  if (bits != 16) return 'must be 16-bit';
  if (dataBytes == null) return 'missing audio data';
  final seconds = dataBytes / (44100 * 2);
  if (seconds > 5) return 'longer than 5.0 seconds';
  return null;
}

int _le16(List<int> bytes, int offset) =>
    bytes[offset] | (bytes[offset + 1] << 8);

int _le32(List<int> bytes, int offset) =>
    bytes[offset] |
    (bytes[offset + 1] << 8) |
    (bytes[offset + 2] << 16) |
    (bytes[offset + 3] << 24);
