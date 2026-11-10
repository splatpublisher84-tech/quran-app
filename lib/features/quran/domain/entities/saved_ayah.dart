import 'package:freezed_annotation/freezed_annotation.dart';

import 'ayah_ref.dart';

part 'saved_ayah.freezed.dart';

/// A row in the saved-ayah store. Text is loaded from the Quran assets.
@freezed
abstract class SavedAyahRecord with _$SavedAyahRecord {
  const factory SavedAyahRecord({
    required AyahRef ref,
    required DateTime savedAt,
  }) = _SavedAyahRecord;
}

/// A saved ayah ready to show, in the reader's current translation.
@freezed
abstract class SavedAyah with _$SavedAyah {
  const factory SavedAyah({
    required AyahRef ref,
    required DateTime savedAt,
    required String arabic,
    required String translation,
  }) = _SavedAyah;
}
