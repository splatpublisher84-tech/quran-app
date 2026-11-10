import 'package:freezed_annotation/freezed_annotation.dart';

part 'translator_note.freezed.dart';

/// One footnote of a translation, identified by the `[n]` marker in the text.
@freezed
abstract class TranslatorNote with _$TranslatorNote {
  const factory TranslatorNote({required int marker, required String text}) =
      _TranslatorNote;
}
