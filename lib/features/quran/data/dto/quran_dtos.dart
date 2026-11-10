import 'package:json_annotation/json_annotation.dart';

part 'quran_dtos.g.dart';

/// `meta.json`: surah list, Juz marks and translation metadata.
@JsonSerializable(createToJson: false)
class QuranMetaDto {
  const QuranMetaDto({
    required this.translations,
    required this.surahs,
    required this.juzs,
  });

  factory QuranMetaDto.fromJson(Map<String, dynamic> json) =>
      _$QuranMetaDtoFromJson(json);

  final Map<String, TranslationInfoDto> translations;
  final List<SurahMetaDto> surahs;
  final List<JuzStartDto> juzs;
}

@JsonSerializable(createToJson: false)
class TranslationInfoDto {
  const TranslationInfoDto({
    required this.key,
    required this.title,
    required this.version,
  });

  factory TranslationInfoDto.fromJson(Map<String, dynamic> json) =>
      _$TranslationInfoDtoFromJson(json);

  final String key;
  final String title;
  final String version;
}

@JsonSerializable(createToJson: false)
class SurahMetaDto {
  const SurahMetaDto({
    required this.n,
    required this.name,
    required this.meaning,
    required this.ar,
    required this.ayahs,
    required this.place,
  });

  factory SurahMetaDto.fromJson(Map<String, dynamic> json) =>
      _$SurahMetaDtoFromJson(json);

  final int n;
  final String name;
  final String meaning;
  final String ar;
  final int ayahs;
  final String place;
}

@JsonSerializable(createToJson: false)
class JuzStartDto {
  const JuzStartDto({required this.surah, required this.ayah});

  factory JuzStartDto.fromJson(Map<String, dynamic> json) =>
      _$JuzStartDtoFromJson(json);

  final int surah;
  final int ayah;
}

/// `arabic/NNN.json`: Arabic text of one surah.
@JsonSerializable(createToJson: false)
class ArabicSurahDto {
  const ArabicSurahDto({required this.surah, required this.ayahs});

  factory ArabicSurahDto.fromJson(Map<String, dynamic> json) =>
      _$ArabicSurahDtoFromJson(json);

  final int surah;
  final List<String> ayahs;
}

/// `<lang>/NNN.json`: translation of one surah.
@JsonSerializable(createToJson: false)
class TranslationSurahDto {
  const TranslationSurahDto({required this.surah, required this.ayahs});

  factory TranslationSurahDto.fromJson(Map<String, dynamic> json) =>
      _$TranslationSurahDtoFromJson(json);

  final int surah;
  final List<TranslationAyahDto> ayahs;
}

@JsonSerializable(createToJson: false)
class TranslationAyahDto {
  const TranslationAyahDto({required this.t, this.f});

  factory TranslationAyahDto.fromJson(Map<String, dynamic> json) =>
      _$TranslationAyahDtoFromJson(json);

  /// Translation text, may contain `[n]` footnote markers.
  final String t;

  /// Raw footnote block, absent when the ayah has none.
  final String? f;
}
