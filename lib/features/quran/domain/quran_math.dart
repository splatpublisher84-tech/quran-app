/// Pure functions over Quran structure. No I/O, no Flutter.
library;

import 'entities/ayah_ref.dart';
import 'entities/juz.dart';
import 'entities/surah.dart';
import 'entities/translator_note.dart';

const int surahCount = 114;

/// Ayah ranges of [juzNumber] grouped by surah. [juzs] must be sorted by
/// number, and [surahs] must be sorted by number starting at 1.
List<JuzSection> juzSections({
  required List<Juz> juzs,
  required List<Surah> surahs,
  required int juzNumber,
}) {
  if (juzNumber < 1 || juzNumber > juzs.length) return const [];
  final start = juzs[juzNumber - 1].start;
  final nextStart = juzNumber < juzs.length ? juzs[juzNumber].start : null;

  // When the next Juz begins at ayah 1, the previous surah is the last one.
  final lastSurah = nextStart == null
      ? surahs.length
      : (nextStart.ayah == 1 ? nextStart.surah - 1 : nextStart.surah);

  final sections = <JuzSection>[];
  for (var s = start.surah; s <= lastSurah; s++) {
    final from = s == start.surah ? start.ayah : 1;
    final to = (nextStart != null && s == nextStart.surah)
        ? nextStart.ayah - 1
        : surahs[s - 1].ayahCount;
    sections.add(JuzSection(surah: s, fromAyah: from, toAyah: to));
  }
  return sections;
}

/// Juz number that contains [ref].
int juzOfAyah({required List<Juz> juzs, required AyahRef ref}) {
  var juz = 1;
  for (final j in juzs) {
    final started =
        ref.surah > j.start.surah ||
        (ref.surah == j.start.surah && ref.ayah >= j.start.ayah);
    if (started) juz = j.number;
  }
  return juz;
}

final RegExp _goToPattern = RegExp(r'^(\d{1,3})\s*[:.]\s*(\d{1,3})$');

/// Parses a "surah:ayah" search such as `2:255`. Returns null when the input
/// is not in that form or points outside the Quran.
AyahRef? parseAyahReference(String input, List<Surah> surahs) {
  final match = _goToPattern.firstMatch(input.trim());
  if (match == null) return null;
  final surah = int.parse(match.group(1)!);
  final ayah = int.parse(match.group(2)!);
  if (surah < 1 || surah > surahs.length) return null;
  final meta = surahs[surah - 1];
  if (ayah < 1 || ayah > meta.ayahCount) return null;
  return AyahRef(surah: surah, ayah: ayah);
}

final RegExp _footnoteSplit = RegExp(r'(?=\[\d+\])');
final RegExp _footnoteItem = RegExp(r'^\[(\d+)\]\s*([\s\S]*)$');

/// Splits a raw footnote block such as `[2011] text [2012] text` into notes.
/// Only `[digits]` at the start of a note counts as a marker. Other brackets
/// such as `[who is]` belong to the text.
List<TranslatorNote> parseFootnotes(String? raw) {
  if (raw == null || raw.trim().isEmpty) return const [];
  final notes = <TranslatorNote>[];
  for (final part in raw.split(_footnoteSplit)) {
    final match = _footnoteItem.firstMatch(part.trim());
    if (match == null) continue;
    notes.add(
      TranslatorNote(
        marker: int.parse(match.group(1)!),
        text: match.group(2)!.trim(),
      ),
    );
  }
  return notes;
}
