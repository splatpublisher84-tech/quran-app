/// Display rules from `dev-handoff/04-quran-data`. No I/O, no Flutter.
library;

/// Basmala in the QuranEnc Arabic text (surah 1, ayah 1). Shown above a
/// surah when that surah does not already begin with it.
const String basmalaText =
    '\u0628\u0650\u0633\u06E1\u0645\u0650 \u0671\u0644\u0644\u0651\u064E\u0647\u0650 '
    '\u0671\u0644\u0631\u0651\u064E\u062D\u06E1\u0645\u064E\u0670\u0646\u0650 '
    '\u0671\u0644\u0631\u0651\u064E\u062D\u0650\u064A\u0645\u0650';

const String _arabicDigits =
    '\u0660\u0661\u0662\u0663\u0664\u0665\u0666\u0667\u0668\u0669';

/// Western digits rewritten as Arabic-Indic digits.
String arabicNumber(int value) {
  final buffer = StringBuffer();
  for (final unit in value.toString().codeUnits) {
    final digit = unit - 0x30;
    buffer.write(digit >= 0 && digit <= 9 ? _arabicDigits[digit] : unit);
  }
  return buffer.toString();
}

/// Extra basmala line. Surah 1 already is the basmala. Surah 9 has none.
/// A section that starts after ayah 1 does not repeat it.
bool showsBasmala({required int surahNumber, required int fromAyah}) {
  if (fromAyah != 1) return false;
  return surahNumber != 1 && surahNumber != 9;
}

/// One piece of a translation after footnote markers are split out.
sealed class TranslationPiece {
  const TranslationPiece();
}

final class TranslationTextPiece extends TranslationPiece {
  const TranslationTextPiece(this.text);

  final String text;
}

final class TranslationMarkerPiece extends TranslationPiece {
  const TranslationMarkerPiece(this.marker);

  final int marker;
}

final RegExp _markerPattern = RegExp(r'\[(\d+)\]');

/// Splits `[12]` markers out of a translation. `[who is]` stays as text.
List<TranslationPiece> splitTranslation(String text) {
  final pieces = <TranslationPiece>[];
  var start = 0;
  for (final match in _markerPattern.allMatches(text)) {
    if (match.start > start) {
      pieces.add(TranslationTextPiece(text.substring(start, match.start)));
    }
    pieces.add(TranslationMarkerPiece(int.parse(match.group(1)!)));
    start = match.end;
  }
  if (start < text.length) {
    pieces.add(TranslationTextPiece(text.substring(start)));
  }
  return pieces;
}

/// Translation with `[n]` markers removed, for short previews.
String translationPreview(String text) =>
    text.replaceAll(_markerPattern, '').replaceAll(RegExp(r'\s+'), ' ').trim();
