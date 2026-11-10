import 'package:freezed_annotation/freezed_annotation.dart';

import 'quran_language.dart';

part 'quran_translation.freezed.dart';

@freezed
abstract class QuranTranslation with _$QuranTranslation {
  const factory QuranTranslation({
    required QuranLanguage language,
    required String title,
    required String version,
  }) = _QuranTranslation;

  const QuranTranslation._();

  /// Attribution required by QuranEnc: title, source and version.
  String get attribution => '$title · QuranEnc.com · v$version';
}
