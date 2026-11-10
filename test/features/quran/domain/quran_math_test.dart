import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/quran/domain/entities/ayah_ref.dart';
import 'package:quran_app/features/quran/domain/entities/juz.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/domain/quran_math.dart';

Surah _surah(int n, int ayahs) => Surah(
  number: n,
  englishName: 'S$n',
  meaning: '',
  arabicName: 'سُورَةُ س$n',
  ayahCount: ayahs,
  revelation: RevelationPlace.meccan,
);

void main() {
  // Three small surahs: 7, 10 and 5 ayahs. Juz 1 covers 1:1 to 2:3 and
  // Juz 2 starts at 2:4, Juz 3 starts at 3:1 (next surah begins at ayah 1).
  final surahs = [_surah(1, 7), _surah(2, 10), _surah(3, 5)];
  final juzs = [
    const Juz(number: 1, start: AyahRef(surah: 1, ayah: 1)),
    const Juz(number: 2, start: AyahRef(surah: 2, ayah: 4)),
    const Juz(number: 3, start: AyahRef(surah: 3, ayah: 1)),
  ];

  group('juzSections', () {
    test('splits a Juz that crosses a surah boundary', () {
      final sections = juzSections(juzs: juzs, surahs: surahs, juzNumber: 1);
      expect(sections.map((s) => (s.surah, s.fromAyah, s.toAyah)).toList(), [
        (1, 1, 7),
        (2, 1, 3),
      ]);
    });

    test('starts mid surah and stops before a next Juz at ayah 1', () {
      // Juz 3 begins at 3:1, so Juz 2 ends at the last ayah of surah 2.
      final sections = juzSections(juzs: juzs, surahs: surahs, juzNumber: 2);
      expect(sections.map((s) => (s.surah, s.fromAyah, s.toAyah)).toList(), [
        (2, 4, 10),
      ]);
    });

    test('last Juz runs to the end of the Quran', () {
      final sections = juzSections(juzs: juzs, surahs: surahs, juzNumber: 3);
      expect(sections.map((s) => (s.surah, s.fromAyah, s.toAyah)).toList(), [
        (3, 1, 5),
      ]);
    });

    test('returns nothing for an unknown Juz', () {
      expect(juzSections(juzs: juzs, surahs: surahs, juzNumber: 9), isEmpty);
    });
  });

  group('juzOfAyah', () {
    test('finds the Juz that contains the ayah', () {
      int of(int s, int a) => juzOfAyah(
        juzs: juzs,
        ref: AyahRef(surah: s, ayah: a),
      );
      expect(of(1, 1), 1);
      expect(of(2, 3), 1);
      expect(of(2, 4), 2);
      expect(of(3, 5), 3);
    });
  });

  group('parseAyahReference', () {
    test('accepts surah:ayah with spaces', () {
      expect(
        parseAyahReference(' 2 : 10 ', surahs),
        const AyahRef(surah: 2, ayah: 10),
      );
    });

    test('accepts a dot separator', () {
      expect(
        parseAyahReference('1.7', surahs),
        const AyahRef(surah: 1, ayah: 7),
      );
    });

    test('rejects ayah beyond the surah', () {
      expect(parseAyahReference('1:8', surahs), isNull);
    });

    test('rejects surah beyond the Quran', () {
      expect(parseAyahReference('4:1', surahs), isNull);
    });

    test('rejects zero and free text', () {
      expect(parseAyahReference('0:1', surahs), isNull);
      expect(parseAyahReference('ayat al kursi', surahs), isNull);
      expect(parseAyahReference('', surahs), isNull);
    });
  });

  group('parseFootnotes', () {
    test('splits notes on their [n] markers', () {
      final notes = parseFootnotes(
        '[2011] Alone, without another.\n[2012] He who is absolute.',
      );
      expect(notes.length, 2);
      expect(notes[0].marker, 2011);
      expect(notes[0].text, 'Alone, without another.');
      expect(notes[1].marker, 2012);
      expect(notes[1].text, 'He who is absolute.');
    });

    test('keeps brackets that are not numeric markers inside the text', () {
      final notes = parseFootnotes('[5] Said by [who is] present.');
      expect(notes.single.text, 'Said by [who is] present.');
    });

    test('returns nothing for null or blank input', () {
      expect(parseFootnotes(null), isEmpty);
      expect(parseFootnotes('   '), isEmpty);
    });
  });

  group('Surah.displayArabicName', () {
    test('drops the leading surah word', () {
      expect(_surah(1, 7).displayArabicName, 'س1');
    });
  });
}
