import '../../../../core/error/result.dart';
import '../entities/ayah_ref.dart';
import '../entities/saved_ayah.dart';

/// Local store of ayahs the reader has saved. Works offline.
abstract interface class SavedAyahRepository {
  /// Newest first.
  Future<Result<List<SavedAyahRecord>>> getAll();

  Future<Result<void>> save(AyahRef ref);

  Future<Result<void>> remove(AyahRef ref);
}
