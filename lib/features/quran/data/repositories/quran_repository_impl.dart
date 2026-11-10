import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/entities/ayah_ref.dart';
import '../../domain/entities/juz.dart';
import '../../domain/entities/quran_language.dart';
import '../../domain/entities/quran_translation.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/asset_quran_data_source.dart';
import '../dto/quran_dtos.dart';

class QuranRepositoryImpl implements QuranRepository {
  QuranRepositoryImpl(this._source);

  final AssetQuranDataSource _source;

  /// Loaded once per app run. The meta file is small and read by many screens.
  Future<QuranMetaDto>? _meta;

  /// A failed read is not cached, so the next call retries.
  Future<QuranMetaDto> _loadMeta() async {
    final cached = _meta;
    if (cached != null) return cached;
    final pending = _source.readMeta();
    _meta = pending;
    try {
      return await pending;
    } catch (_) {
      _meta = null;
      rethrow;
    }
  }

  @override
  Future<Result<List<Surah>>> getSurahs() => guardResult(() async {
    final meta = await _loadMeta();
    return [for (final s in meta.surahs) _mapSurah(s)];
  });

  @override
  Future<Result<List<Juz>>> getJuzs() => guardResult(() async {
    final meta = await _loadMeta();
    return [
      for (var i = 0; i < meta.juzs.length; i++)
        Juz(
          number: i + 1,
          start: AyahRef(surah: meta.juzs[i].surah, ayah: meta.juzs[i].ayah),
        ),
    ];
  });

  @override
  Future<Result<List<Ayah>>> getAyahs({
    required int surahNumber,
    required QuranLanguage language,
  }) => guardResult(() async {
    final arabic = await _source.readArabic(surahNumber);
    final translation = await _source.readTranslation(
      language: language,
      surah: surahNumber,
    );
    if (arabic.ayahs.length != translation.ayahs.length) {
      throw AppException(
        StorageFailure(
          'Surah $surahNumber: ${arabic.ayahs.length} Arabic ayahs, '
          '${translation.ayahs.length} translated ayahs',
        ),
      );
    }
    return [
      for (var i = 0; i < arabic.ayahs.length; i++)
        Ayah(
          ref: AyahRef(surah: surahNumber, ayah: i + 1),
          arabic: arabic.ayahs[i],
          translation: translation.ayahs[i].t,
          footnotes: translation.ayahs[i].f,
        ),
    ];
  });

  @override
  Future<Result<List<QuranTranslation>>> getTranslations() =>
      guardResult(() async {
        final meta = await _loadMeta();
        return [
          for (final entry in meta.translations.entries)
            if (QuranLanguage.tryParse(entry.key) case final lang?)
              QuranTranslation(
                language: lang,
                title: entry.value.title,
                version: entry.value.version,
              ),
        ];
      });

  static Surah _mapSurah(SurahMetaDto dto) => Surah(
    number: dto.n,
    englishName: dto.name,
    meaning: dto.meaning,
    arabicName: dto.ar,
    ayahCount: dto.ayahs,
    revelation: _mapRevelation(dto.place),
  );

  static RevelationPlace _mapRevelation(String place) =>
      switch (place.toLowerCase()) {
        'meccan' => RevelationPlace.meccan,
        'medinan' => RevelationPlace.medinan,
        _ => RevelationPlace.unknown,
      };
}
