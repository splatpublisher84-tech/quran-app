import 'package:freezed_annotation/freezed_annotation.dart';

import 'arabic_text_size.dart';
import 'ayah_ref.dart';
import 'quran_language.dart';

part 'reading_settings.freezed.dart';

/// Choices that change how the reader renders, plus the last opened ayah.
@freezed
abstract class ReadingSettings with _$ReadingSettings {
  const factory ReadingSettings({
    required QuranLanguage language,
    required ArabicTextSize arabicSize,
    AyahRef? lastRead,
  }) = _ReadingSettings;
}
