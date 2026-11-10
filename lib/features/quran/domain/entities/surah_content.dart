import 'package:freezed_annotation/freezed_annotation.dart';

import 'ayah.dart';
import 'quran_language.dart';
import 'surah.dart';

part 'surah_content.freezed.dart';

/// A surah with all its ayahs in one translation language.
@freezed
abstract class SurahContent with _$SurahContent {
  const factory SurahContent({
    required Surah surah,
    required QuranLanguage language,
    required List<Ayah> ayahs,
  }) = _SurahContent;
}
