import 'package:freezed_annotation/freezed_annotation.dart';

import 'juz.dart';
import 'surah.dart';

part 'quran_catalog.freezed.dart';

/// Surah list and Juz marks needed by the index. Loaded once from assets.
@freezed
abstract class QuranCatalog with _$QuranCatalog {
  const factory QuranCatalog({
    required List<Surah> surahs,
    required List<Juz> juzs,
  }) = _QuranCatalog;
}
