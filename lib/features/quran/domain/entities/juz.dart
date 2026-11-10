import 'package:freezed_annotation/freezed_annotation.dart';

import 'ayah_ref.dart';

part 'juz.freezed.dart';

/// A Juz starts at [start]. The end is the ayah before the next Juz start.
@freezed
abstract class Juz with _$Juz {
  const factory Juz({required int number, required AyahRef start}) = _Juz;
}

/// Part of a Juz that falls inside one surah. Ayah bounds are inclusive.
@freezed
abstract class JuzSection with _$JuzSection {
  const factory JuzSection({
    required int surah,
    required int fromAyah,
    required int toAyah,
  }) = _JuzSection;
}
