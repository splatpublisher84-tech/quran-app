// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranMetaDto _$QuranMetaDtoFromJson(Map<String, dynamic> json) => QuranMetaDto(
  translations: (json['translations'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, TranslationInfoDto.fromJson(e as Map<String, dynamic>)),
  ),
  surahs: (json['surahs'] as List<dynamic>)
      .map((e) => SurahMetaDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  juzs: (json['juzs'] as List<dynamic>)
      .map((e) => JuzStartDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

TranslationInfoDto _$TranslationInfoDtoFromJson(Map<String, dynamic> json) =>
    TranslationInfoDto(
      key: json['key'] as String,
      title: json['title'] as String,
      version: json['version'] as String,
    );

SurahMetaDto _$SurahMetaDtoFromJson(Map<String, dynamic> json) => SurahMetaDto(
  n: (json['n'] as num).toInt(),
  name: json['name'] as String,
  meaning: json['meaning'] as String,
  ar: json['ar'] as String,
  ayahs: (json['ayahs'] as num).toInt(),
  place: json['place'] as String,
);

JuzStartDto _$JuzStartDtoFromJson(Map<String, dynamic> json) => JuzStartDto(
  surah: (json['surah'] as num).toInt(),
  ayah: (json['ayah'] as num).toInt(),
);

ArabicSurahDto _$ArabicSurahDtoFromJson(Map<String, dynamic> json) =>
    ArabicSurahDto(
      surah: (json['surah'] as num).toInt(),
      ayahs: (json['ayahs'] as List<dynamic>).map((e) => e as String).toList(),
    );

TranslationSurahDto _$TranslationSurahDtoFromJson(Map<String, dynamic> json) =>
    TranslationSurahDto(
      surah: (json['surah'] as num).toInt(),
      ayahs: (json['ayahs'] as List<dynamic>)
          .map((e) => TranslationAyahDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

TranslationAyahDto _$TranslationAyahDtoFromJson(Map<String, dynamic> json) =>
    TranslationAyahDto(t: json['t'] as String, f: json['f'] as String?);
