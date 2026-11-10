import '../../../../core/error/result.dart';
import '../entities/ayah.dart';
import '../entities/juz.dart';
import '../entities/quran_language.dart';
import '../entities/quran_translation.dart';
import '../entities/surah.dart';

/// Read access to the bundled Quran. Every method works offline.
abstract interface class QuranRepository {
  /// All 114 surahs, sorted by number.
  Future<Result<List<Surah>>> getSurahs();

  /// All 30 Juz, sorted by number.
  Future<Result<List<Juz>>> getJuzs();

  /// Ayahs of [surahNumber] with the Arabic text and the [language]
  /// translation, sorted by ayah number.
  Future<Result<List<Ayah>>> getAyahs({
    required int surahNumber,
    required QuranLanguage language,
  });

  /// Metadata (title, version) of every translation shipped in the app.
  Future<Result<List<QuranTranslation>>> getTranslations();
}
