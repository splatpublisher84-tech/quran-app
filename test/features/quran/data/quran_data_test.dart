import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/error/failure.dart';
import 'package:quran_app/features/quran/data/datasources/asset_quran_data_source.dart';
import 'package:quran_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:quran_app/features/quran/domain/entities/ayah_ref.dart';
import 'package:quran_app/features/quran/domain/entities/quran_language.dart';
import 'package:quran_app/features/quran/domain/quran_math.dart';
import 'package:quran_app/features/quran/domain/usecases/quran_use_cases.dart';

/// Runs against the real bundled data in assets/data/quran.
void main() {
  late QuranRepositoryImpl repo;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    repo = QuranRepositoryImpl(AssetQuranDataSource(rootBundle));
  });

  group('bundled Quran data', () {
    test('has 114 surahs and 30 Juz', () async {
      final surahs = (await repo.getSurahs()).valueOrNull!;
      final juzs = (await repo.getJuzs()).valueOrNull!;
      expect(surahs.length, 114);
      expect(juzs.length, 30);
      expect(surahs.map((s) => s.ayahCount).reduce((a, b) => a + b), 6236);
    });

    test('Surah 1 starts with the expected Arabic text', () async {
      final ayahs = (await repo.getAyahs(
        surahNumber: 1,
        language: QuranLanguage.en,
      )).valueOrNull!;
      expect(ayahs.length, 7);
      // Checked by code point: starts with Ba (U+0628) and uses the Quranic
      // alif wasl (U+0671) from QuranEnc, not plain Alif.
      expect(ayahs.first.arabic.codeUnitAt(0), 0x0628);
      expect(ayahs.first.arabic, contains('\u0671'));
      expect(ayahs.first.ref, const AyahRef(surah: 1, ayah: 1));
    });

    test('every ayah has text in all four languages', () async {
      final surahs = (await repo.getSurahs()).valueOrNull!;
      var total = 0;
      for (final lang in QuranLanguage.values) {
        total = 0;
        for (final s in surahs) {
          final ayahs = (await repo.getAyahs(
            surahNumber: s.number,
            language: lang,
          )).valueOrNull!;
          expect(ayahs.length, s.ayahCount, reason: 'surah ${s.number} $lang');
          for (final a in ayahs) {
            expect(a.arabic.trim(), isNotEmpty, reason: '${a.ref.key} arabic');
            expect(
              a.translation.trim(),
              isNotEmpty,
              reason: '${a.ref.key} $lang',
            );
          }
          total += ayahs.length;
        }
        expect(total, 6236, reason: '$lang');
      }
    });

    test('Juz sections cover every ayah exactly once', () async {
      final surahs = (await repo.getSurahs()).valueOrNull!;
      final juzs = (await repo.getJuzs()).valueOrNull!;
      final seen = <String>{};
      for (final juz in juzs) {
        final sections = juzSections(
          juzs: juzs,
          surahs: surahs,
          juzNumber: juz.number,
        );
        expect(sections, isNotEmpty, reason: 'juz ${juz.number}');
        for (final sec in sections) {
          for (var a = sec.fromAyah; a <= sec.toAyah; a++) {
            final key = '${sec.surah}:$a';
            expect(seen.add(key), isTrue, reason: 'duplicate $key');
          }
        }
      }
      expect(seen.length, 6236);
    });

    test('juzOfAyah agrees with the Juz start marks', () async {
      final juzs = (await repo.getJuzs()).valueOrNull!;
      for (final juz in juzs) {
        expect(
          juzOfAyah(juzs: juzs, ref: juz.start),
          juz.number,
          reason: 'start of juz ${juz.number}',
        );
      }
      // Ayah just before a Juz start belongs to the previous Juz.
      final juz2 = juzs[1].start;
      expect(
        juzOfAyah(
          juzs: juzs,
          ref: AyahRef(surah: juz2.surah, ayah: juz2.ayah - 1),
        ),
        1,
      );
    });

    test('translations expose attribution for the four languages', () async {
      final list = (await repo.getTranslations()).valueOrNull!;
      expect(list.map((t) => t.language).toSet(), {
        QuranLanguage.en,
        QuranLanguage.id,
        QuranLanguage.ur,
        QuranLanguage.tr,
      });
      for (final t in list) {
        expect(t.attribution, startsWith(t.title));
        expect(t.attribution, contains('QuranEnc.com'));
      }
    });
  });

  group('use cases', () {
    test('GetSurah returns the surah with its ayahs', () async {
      final result = await GetSurah(repo)(
        surahNumber: 112,
        language: QuranLanguage.id,
      );
      final content = result.valueOrNull!;
      expect(content.surah.number, 112);
      expect(content.ayahs.length, 4);
      expect(content.language, QuranLanguage.id);
    });

    test('GetSurah rejects an out of range surah', () async {
      final result = await GetSurah(repo)(
        surahNumber: 115,
        language: QuranLanguage.en,
      );
      expect(result.failureOrNull, isA<UnknownFailure>());
    });

    test('ParseAyahReference resolves 2:255 against real data', () async {
      final result = await ParseAyahReference(repo)('2:255');
      expect(result.valueOrNull, const AyahRef(surah: 2, ayah: 255));
    });

    test('ParseAyahReference rejects 2:300', () async {
      final result = await ParseAyahReference(repo)('2:300');
      expect(result.valueOrNull, isNull);
    });

    test('FindJuzOfAyah finds Juz 1 for 2:141', () async {
      final result = await FindJuzOfAyah(repo)(
        const AyahRef(surah: 2, ayah: 141),
      );
      expect(result.valueOrNull, 1);
    });

    test('GetJuzSections rejects Juz 31', () async {
      final result = await GetJuzSections(repo)(31);
      expect(result.failureOrNull, isA<UnknownFailure>());
    });
  });

  group('failures', () {
    test('a missing asset becomes a StorageFailure', () async {
      final broken = QuranRepositoryImpl(AssetQuranDataSource(_EmptyBundle()));
      final result = await broken.getSurahs();
      expect(result.failureOrNull, isA<StorageFailure>());
    });
  });
}

class _EmptyBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    throw FlutterError('Unable to load asset: $key');
  }
}
