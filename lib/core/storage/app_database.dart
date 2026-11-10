import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Ayahs the reader has saved. Later milestones add their tables here.
class SavedAyahRows extends Table {
  IntColumn get surah => integer()();

  IntColumn get ayah => integer()();

  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {surah, ayah};
}

@DriftDatabase(tables: [SavedAyahRows])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}

/// Opens the on-device database. Tests pass [NativeDatabase.memory] instead.
QueryExecutor openAppDatabase() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'quran.sqlite'));
    return NativeDatabase(file);
  });
}
