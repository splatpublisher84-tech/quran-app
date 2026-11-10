import 'package:freezed_annotation/freezed_annotation.dart';

import 'ayah_ref.dart';

part 'ayah.freezed.dart';

@freezed
abstract class Ayah with _$Ayah {
  const factory Ayah({
    required AyahRef ref,
    required String arabic,
    required String translation,

    /// Raw footnote block from the source. Parse it with `parseFootnotes`.
    String? footnotes,
  }) = _Ayah;
}
