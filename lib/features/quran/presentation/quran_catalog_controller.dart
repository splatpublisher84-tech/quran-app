import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/quran_catalog.dart';
import 'quran_providers.dart';

class QuranCatalogController extends AsyncNotifier<QuranCatalog> {
  @override
  Future<QuranCatalog> build() async {
    final surahsResult = await ref.watch(getSurahListProvider)();
    final surahs = surahsResult.valueOrNull;
    if (surahs == null) throw surahsResult.failureOrNull!;

    final juzsResult = await ref.watch(getJuzListProvider)();
    final juzs = juzsResult.valueOrNull;
    if (juzs == null) throw juzsResult.failureOrNull!;

    return QuranCatalog(surahs: surahs, juzs: juzs);
  }
}

final quranCatalogProvider =
    AsyncNotifierProvider<QuranCatalogController, QuranCatalog>(
      QuranCatalogController.new,
    );
