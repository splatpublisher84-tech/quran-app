import 'package:freezed_annotation/freezed_annotation.dart';

import 'entities/ayah.dart';
import 'entities/ayah_ref.dart';
import 'entities/surah.dart';
import 'quran_display.dart';

part 'reader_blocks.freezed.dart';

/// One surah slice inside a reader page. [ayahs] are already cut to the range.
class ReaderSection {
  const ReaderSection({
    required this.surah,
    required this.fromAyah,
    required this.ayahs,
  });

  final Surah surah;
  final int fromAyah;
  final List<Ayah> ayahs;
}

/// A reader page: headers, basmala, ayahs and the closing attribution.
@freezed
abstract class ReaderDocument with _$ReaderDocument {
  const factory ReaderDocument({required List<ReaderBlock> blocks}) =
      _ReaderDocument;
}

/// One row in the reader list.
@freezed
sealed class ReaderBlock with _$ReaderBlock {
  const factory ReaderBlock.surah(Surah surah) = SurahHeaderBlock;
  const factory ReaderBlock.basmala() = BasmalaBlock;
  const factory ReaderBlock.ayah(Ayah ayah) = AyahBlock;
  const factory ReaderBlock.attribution(String text) = AttributionBlock;
}

/// Builds the row list for one surah or one Juz.
List<ReaderBlock> buildReaderBlocks({
  required List<ReaderSection> sections,
  required String attribution,
}) {
  final blocks = <ReaderBlock>[];
  for (final section in sections) {
    blocks.add(ReaderBlock.surah(section.surah));
    if (showsBasmala(
      surahNumber: section.surah.number,
      fromAyah: section.fromAyah,
    )) {
      blocks.add(const ReaderBlock.basmala());
    }
    for (final ayah in section.ayahs) {
      blocks.add(ReaderBlock.ayah(ayah));
    }
  }
  blocks.add(ReaderBlock.attribution(attribution));
  return blocks;
}

/// First ayah on the page, used as the default continue point.
AyahRef? firstAyahOf(ReaderDocument document) {
  for (final block in document.blocks) {
    if (block case AyahBlock(:final ayah)) return ayah.ref;
  }
  return null;
}
