import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah.freezed.dart';

enum RevelationPlace { meccan, medinan, unknown }

@freezed
abstract class Surah with _$Surah {
  const factory Surah({
    required int number,
    required String englishName,
    required String meaning,

    /// Arabic name as delivered by the source, including the leading
    /// "سُورَةُ" word. Use [displayArabicName] for UI.
    required String arabicName,
    required int ayahCount,
    required RevelationPlace revelation,
  }) = _Surah;

  const Surah._();

  static final RegExp _surahWord = RegExp(r'^سُورَةُ\s*');

  /// Arabic name without the leading "سُورَةُ" word.
  String get displayArabicName => arabicName.replaceFirst(_surahWord, '');
}
