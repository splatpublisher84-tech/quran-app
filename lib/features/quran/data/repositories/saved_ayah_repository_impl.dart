import 'package:drift/drift.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/platform/clock.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/ayah_ref.dart';
import '../../domain/entities/saved_ayah.dart';
import '../../domain/repositories/saved_ayah_repository.dart';

class SavedAyahRepositoryImpl implements SavedAyahRepository {
  SavedAyahRepositoryImpl(this._database, this._clock);

  final AppDatabase _database;
  final AppClock _clock;

  @override
  Future<Result<List<SavedAyahRecord>>> getAll() => guardResult(() async {
    final query = _database.select(_database.savedAyahRows)
      ..orderBy([(row) => OrderingTerm.desc(row.savedAt)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        SavedAyahRecord(
          ref: AyahRef(surah: row.surah, ayah: row.ayah),
          savedAt: row.savedAt,
        ),
    ];
  });

  @override
  Future<Result<void>> save(AyahRef ref) => guardResult(() async {
    try {
      await _database
          .into(_database.savedAyahRows)
          .insert(
            SavedAyahRowsCompanion.insert(
              surah: ref.surah,
              ayah: ref.ayah,
              savedAt: _clock.now(),
            ),
            mode: InsertMode.insertOrReplace,
          );
    } catch (error) {
      throw AppException(StorageFailure('$error'));
    }
  });

  @override
  Future<Result<void>> remove(AyahRef ref) => guardResult(() async {
    try {
      await (_database.delete(_database.savedAyahRows)..where(
            (row) => row.surah.equals(ref.surah) & row.ayah.equals(ref.ayah),
          ))
          .go();
    } catch (error) {
      throw AppException(StorageFailure('$error'));
    }
  });
}
