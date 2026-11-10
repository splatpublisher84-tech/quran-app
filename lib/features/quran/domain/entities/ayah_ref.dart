import 'package:freezed_annotation/freezed_annotation.dart';

part 'ayah_ref.freezed.dart';

/// Position of one ayah. Both numbers are 1 based.
@freezed
abstract class AyahRef with _$AyahRef {
  const factory AyahRef({required int surah, required int ayah}) = _AyahRef;

  const AyahRef._();

  /// Stable key used in persistence and routes, for example `2:255`.
  String get key => '$surah:$ayah';

  /// Reads a stored key. Does not check that the ayah exists.
  static AyahRef? tryParseKey(String? key) {
    if (key == null) return null;
    final parts = key.split(':');
    if (parts.length != 2) return null;
    final surah = int.tryParse(parts[0]);
    final ayah = int.tryParse(parts[1]);
    if (surah == null || ayah == null || surah < 1 || ayah < 1) return null;
    return AyahRef(surah: surah, ayah: ayah);
  }
}
