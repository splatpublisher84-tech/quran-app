import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/ayah_ref.dart';
import '../entities/juz.dart';
import '../entities/quran_language.dart';
import '../entities/quran_translation.dart';
import '../entities/surah.dart';
import '../entities/surah_content.dart';
import '../entities/translator_note.dart';
import '../quran_math.dart';
import '../repositories/quran_repository.dart';

class GetSurahList {
  const GetSurahList(this._repository);

  final QuranRepository _repository;

  Future<Result<List<Surah>>> call() => _repository.getSurahs();
}

class GetSurah {
  const GetSurah(this._repository);

  final QuranRepository _repository;

  Future<Result<SurahContent>> call({
    required int surahNumber,
    required QuranLanguage language,
  }) async {
    if (surahNumber < 1 || surahNumber > surahCount) {
      return const Err(UnknownFailure('Surah number out of range'));
    }
    final surahsResult = await _repository.getSurahs();
    final surahs = surahsResult.valueOrNull;
    if (surahs == null) return Err(surahsResult.failureOrNull!);
    final ayahsResult = await _repository.getAyahs(
      surahNumber: surahNumber,
      language: language,
    );
    final ayahs = ayahsResult.valueOrNull;
    if (ayahs == null) return Err(ayahsResult.failureOrNull!);
    return Ok(
      SurahContent(
        surah: surahs[surahNumber - 1],
        language: language,
        ayahs: ayahs,
      ),
    );
  }
}

class GetJuzList {
  const GetJuzList(this._repository);

  final QuranRepository _repository;

  Future<Result<List<Juz>>> call() => _repository.getJuzs();
}

class GetTranslations {
  const GetTranslations(this._repository);

  final QuranRepository _repository;

  Future<Result<List<QuranTranslation>>> call() =>
      _repository.getTranslations();
}

class GetJuzSections {
  const GetJuzSections(this._repository);

  final QuranRepository _repository;

  Future<Result<List<JuzSection>>> call(int juzNumber) async {
    final surahs = await _repository.getSurahs();
    final juzs = await _repository.getJuzs();
    final surahList = surahs.valueOrNull;
    final juzList = juzs.valueOrNull;
    if (surahList == null) return Err(surahs.failureOrNull!);
    if (juzList == null) return Err(juzs.failureOrNull!);
    if (juzNumber < 1 || juzNumber > juzList.length) {
      return const Err(UnknownFailure('Juz number out of range'));
    }
    return Ok(
      juzSections(juzs: juzList, surahs: surahList, juzNumber: juzNumber),
    );
  }
}

class FindJuzOfAyah {
  const FindJuzOfAyah(this._repository);

  final QuranRepository _repository;

  Future<Result<int>> call(AyahRef ref) async {
    final juzs = await _repository.getJuzs();
    final list = juzs.valueOrNull;
    if (list == null) return Err(juzs.failureOrNull!);
    return Ok(juzOfAyah(juzs: list, ref: ref));
  }
}

class ParseAyahReference {
  const ParseAyahReference(this._repository);

  final QuranRepository _repository;

  /// Returns null when the input is not a valid reference.
  Future<Result<AyahRef?>> call(String input) async {
    final surahs = await _repository.getSurahs();
    final list = surahs.valueOrNull;
    if (list == null) return Err(surahs.failureOrNull!);
    return Ok(parseAyahReference(input, list));
  }
}

class ParseFootnotes {
  const ParseFootnotes();

  List<TranslatorNote> call(String? raw) => parseFootnotes(raw);
}
