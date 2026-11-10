import 'package:flutter_riverpod/misc.dart';

import '../../../core/di/infrastructure_providers.dart';
import '../data/datasources/asset_quran_data_source.dart';
import '../data/repositories/quran_repository_impl.dart';
import '../data/repositories/saved_ayah_repository_impl.dart';
import '../presentation/quran_providers.dart';

/// Binds the Quran interfaces to their implementations.
///
/// The provider tokens live in presentation so screens never import `di`.
List<Override> quranFeatureOverrides() => [
  quranRepositoryProvider.overrideWith((ref) {
    return QuranRepositoryImpl(
      AssetQuranDataSource(ref.watch(quranAssetBundleProvider)),
    );
  }),
  savedAyahRepositoryProvider.overrideWith((ref) {
    return SavedAyahRepositoryImpl(
      ref.watch(appDatabaseProvider),
      ref.watch(clockProvider),
    );
  }),
];
