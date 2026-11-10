import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repositories/quran_repository.dart';
import '../domain/repositories/saved_ayah_repository.dart';
import '../domain/usecases/quran_use_cases.dart';
import '../domain/usecases/reader_use_case.dart';
import '../domain/usecases/saved_ayah_use_cases.dart';

/// Asset bundle for the bundled Quran. Tests can override it.
final quranAssetBundleProvider = Provider<AssetBundle>((ref) => rootBundle);

/// Wired to [QuranRepositoryImpl] from `quran/di`. Screens only see the
/// interface, so this file does not import `data`.
final quranRepositoryProvider = Provider<QuranRepository>(
  (ref) =>
      throw UnimplementedError('quranRepositoryProvider must be overridden'),
);

final savedAyahRepositoryProvider = Provider<SavedAyahRepository>(
  (ref) => throw UnimplementedError(
    'savedAyahRepositoryProvider must be overridden',
  ),
);

final getSurahListProvider = Provider<GetSurahList>(
  (ref) => GetSurahList(ref.watch(quranRepositoryProvider)),
);

final getSurahProvider = Provider<GetSurah>(
  (ref) => GetSurah(ref.watch(quranRepositoryProvider)),
);

final getJuzListProvider = Provider<GetJuzList>(
  (ref) => GetJuzList(ref.watch(quranRepositoryProvider)),
);

final getJuzSectionsProvider = Provider<GetJuzSections>(
  (ref) => GetJuzSections(ref.watch(quranRepositoryProvider)),
);

final findJuzOfAyahProvider = Provider<FindJuzOfAyah>(
  (ref) => FindJuzOfAyah(ref.watch(quranRepositoryProvider)),
);

final parseAyahReferenceProvider = Provider<ParseAyahReference>(
  (ref) => ParseAyahReference(ref.watch(quranRepositoryProvider)),
);

final parseFootnotesProvider = Provider<ParseFootnotes>(
  (ref) => const ParseFootnotes(),
);

final getTranslationsProvider = Provider<GetTranslations>(
  (ref) => GetTranslations(ref.watch(quranRepositoryProvider)),
);

final getReaderProvider = Provider<GetReader>(
  (ref) => GetReader(ref.watch(quranRepositoryProvider)),
);

final getSavedAyahsProvider = Provider<GetSavedAyahs>(
  (ref) => GetSavedAyahs(
    ref.watch(quranRepositoryProvider),
    ref.watch(savedAyahRepositoryProvider),
  ),
);

final toggleSavedAyahProvider = Provider<ToggleSavedAyah>(
  (ref) => ToggleSavedAyah(ref.watch(savedAyahRepositoryProvider)),
);
