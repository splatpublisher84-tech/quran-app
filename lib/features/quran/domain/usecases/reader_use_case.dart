import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/quran_language.dart';
import '../entities/quran_translation.dart';
import '../entities/surah.dart';
import '../quran_math.dart';
import '../reader_blocks.dart';
import '../repositories/quran_repository.dart';

/// Loads one surah, or one Juz that may cross several surahs.
class GetReader {
  const GetReader(this._repository);

  final QuranRepository _repository;

  Future<Result<ReaderDocument>> call({
    required QuranLanguage language,
    int? surahNumber,
    int? juzNumber,
  }) async {
    if ((surahNumber == null) == (juzNumber == null)) {
      return const Err(UnknownFailure('Reader needs a surah or a juz'));
    }

    final surahsResult = await _repository.getSurahs();
    final surahs = surahsResult.valueOrNull;
    if (surahs == null) return Err(surahsResult.failureOrNull!);

    final translationsResult = await _repository.getTranslations();
    final translations = translationsResult.valueOrNull;
    if (translations == null) return Err(translationsResult.failureOrNull!);

    final sections = surahNumber != null
        ? await _oneSurah(surahs, surahNumber, language)
        : await _oneJuz(surahs, juzNumber!, language);
    final list = sections.valueOrNull;
    if (list == null) return Err(sections.failureOrNull!);

    return Ok(
      ReaderDocument(
        blocks: buildReaderBlocks(
          sections: list,
          attribution: _attribution(translations, language),
        ),
      ),
    );
  }

  Future<Result<List<ReaderSection>>> _oneSurah(
    List<Surah> surahs,
    int surahNumber,
    QuranLanguage language,
  ) async {
    if (surahNumber < 1 || surahNumber > surahs.length) {
      return const Err(UnknownFailure('Surah number out of range'));
    }
    final section = await _section(
      surah: surahs[surahNumber - 1],
      fromAyah: 1,
      toAyah: surahs[surahNumber - 1].ayahCount,
      language: language,
    );
    final value = section.valueOrNull;
    if (value == null) return Err(section.failureOrNull!);
    return Ok([value]);
  }

  Future<Result<List<ReaderSection>>> _oneJuz(
    List<Surah> surahs,
    int juzNumber,
    QuranLanguage language,
  ) async {
    final juzsResult = await _repository.getJuzs();
    final juzs = juzsResult.valueOrNull;
    if (juzs == null) return Err(juzsResult.failureOrNull!);
    final ranges = juzSections(
      juzs: juzs,
      surahs: surahs,
      juzNumber: juzNumber,
    );
    if (ranges.isEmpty) {
      return const Err(UnknownFailure('Juz number out of range'));
    }
    final sections = <ReaderSection>[];
    for (final range in ranges) {
      final section = await _section(
        surah: surahs[range.surah - 1],
        fromAyah: range.fromAyah,
        toAyah: range.toAyah,
        language: language,
      );
      final value = section.valueOrNull;
      if (value == null) return Err(section.failureOrNull!);
      sections.add(value);
    }
    return Ok(sections);
  }

  Future<Result<ReaderSection>> _section({
    required Surah surah,
    required int fromAyah,
    required int toAyah,
    required QuranLanguage language,
  }) async {
    final ayahsResult = await _repository.getAyahs(
      surahNumber: surah.number,
      language: language,
    );
    final ayahs = ayahsResult.valueOrNull;
    if (ayahs == null) return Err(ayahsResult.failureOrNull!);
    return Ok(
      ReaderSection(
        surah: surah,
        fromAyah: fromAyah,
        ayahs: [
          for (final ayah in ayahs)
            if (ayah.ref.ayah >= fromAyah && ayah.ref.ayah <= toAyah) ayah,
        ],
      ),
    );
  }

  String _attribution(
    List<QuranTranslation> translations,
    QuranLanguage language,
  ) {
    for (final translation in translations) {
      if (translation.language == language) return translation.attribution;
    }
    return 'QuranEnc.com';
  }
}
