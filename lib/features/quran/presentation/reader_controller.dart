import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/reader_blocks.dart';
import 'quran_providers.dart';
import 'reading_settings_controller.dart';

/// Opens either one surah or one Juz.
final class ReaderQuery {
  const ReaderQuery.surah(this.surah) : juz = null;

  const ReaderQuery.juz(this.juz) : surah = null;

  final int? surah;
  final int? juz;

  @override
  bool operator ==(Object other) =>
      other is ReaderQuery && other.surah == surah && other.juz == juz;

  @override
  int get hashCode => Object.hash(surah, juz);
}

class ReaderController extends AsyncNotifier<ReaderDocument> {
  ReaderController(this.query);

  final ReaderQuery query;

  @override
  Future<ReaderDocument> build() async {
    final language = ref.watch(
      readingSettingsProvider.select((settings) => settings.language),
    );
    final result = await ref.watch(getReaderProvider)(
      language: language,
      surahNumber: query.surah,
      juzNumber: query.juz,
    );
    final document = result.valueOrNull;
    if (document == null) throw result.failureOrNull!;
    return document;
  }
}

final readerProvider = AsyncNotifierProvider.autoDispose
    .family<ReaderController, ReaderDocument, ReaderQuery>(
      ReaderController.new,
    );
