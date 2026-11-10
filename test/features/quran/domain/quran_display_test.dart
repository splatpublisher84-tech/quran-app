import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/entities/ayah_ref.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/domain/quran_display.dart';
import 'package:quran_app/features/quran/domain/quran_search.dart';
import 'package:quran_app/features/quran/domain/reader_blocks.dart';

Surah _surah(
  int number, {
  int ayahs = 7,
  String name = 'Name',
  String meaning = 'Meaning',
}) => Surah(
  number: number,
  englishName: name,
  meaning: meaning,
  arabicName: 'سُورَةُ مثال',
  ayahCount: ayahs,
  revelation: RevelationPlace.meccan,
);

Ayah _ayah(int surah, int ayah) => Ayah(
  ref: AyahRef(surah: surah, ayah: ayah),
  arabic: 'arabic $ayah',
  translation: 'translation $ayah',
);

void main() {
  test('arabicNumber uses Arabic-Indic digits', () {
    expect(arabicNumber(255), '\u0662\u0665\u0665');
  });

  test('showsBasmala skips surah 1, surah 9 and mid-surah ranges', () {
    expect(showsBasmala(surahNumber: 1, fromAyah: 1), isFalse);
    expect(showsBasmala(surahNumber: 9, fromAyah: 1), isFalse);
    expect(showsBasmala(surahNumber: 2, fromAyah: 1), isTrue);
    expect(showsBasmala(surahNumber: 2, fromAyah: 142), isFalse);
  });

  test('splitTranslation keeps non numeric brackets as text', () {
    final pieces = splitTranslation('Say, "He is Allāh, [who is] One,[2011]');
    expect(pieces, hasLength(2));
    expect(
      (pieces[0] as TranslationTextPiece).text,
      'Say, "He is Allāh, [who is] One,',
    );
    expect((pieces[1] as TranslationMarkerPiece).marker, 2011);
  });

  test('translationPreview drops markers', () {
    expect(translationPreview('One,[2011] two.'), 'One, two.');
  });

  test('filterSurahs matches a meaning and an exact number', () {
    final surahs = [
      _surah(1, name: 'Al-Faatiha', meaning: 'The Opening'),
      _surah(2, name: 'Al-Baqara', meaning: 'The Cow'),
    ];
    expect(filterSurahs(surahs, 'opening').single.number, 1);
    expect(filterSurahs(surahs, '2').single.number, 2);
  });

  test('buildReaderBlocks adds basmala only when the rule says so', () {
    final blocks = buildReaderBlocks(
      attribution: 'English · QuranEnc.com · v1',
      sections: [
        ReaderSection(surah: _surah(1), fromAyah: 1, ayahs: [_ayah(1, 1)]),
        ReaderSection(surah: _surah(2), fromAyah: 1, ayahs: [_ayah(2, 1)]),
        ReaderSection(surah: _surah(2), fromAyah: 142, ayahs: [_ayah(2, 142)]),
      ],
    );
    expect(blocks.whereType<BasmalaBlock>(), hasLength(1));
    expect(blocks.whereType<SurahHeaderBlock>(), hasLength(3));
    expect(blocks.whereType<AyahBlock>(), hasLength(3));
    expect(blocks.last, isA<AttributionBlock>());
    expect(firstAyahOf(ReaderDocument(blocks: blocks))?.key, '1:1');
  });

  test('AyahRef.tryParseKey reads a stored key', () {
    expect(AyahRef.tryParseKey('2:255'), const AyahRef(surah: 2, ayah: 255));
    expect(AyahRef.tryParseKey('nope'), isNull);
  });
}
