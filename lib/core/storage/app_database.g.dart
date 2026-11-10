// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SavedAyahRowsTable extends SavedAyahRows
    with TableInfo<$SavedAyahRowsTable, SavedAyahRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedAyahRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahMeta = const VerificationMeta('surah');
  @override
  late final GeneratedColumn<int> surah = GeneratedColumn<int>(
    'surah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahMeta = const VerificationMeta('ayah');
  @override
  late final GeneratedColumn<int> ayah = GeneratedColumn<int>(
    'ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [surah, ayah, savedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_ayah_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedAyahRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah')) {
      context.handle(
        _surahMeta,
        surah.isAcceptableOrUnknown(data['surah']!, _surahMeta),
      );
    } else if (isInserting) {
      context.missing(_surahMeta);
    }
    if (data.containsKey('ayah')) {
      context.handle(
        _ayahMeta,
        ayah.isAcceptableOrUnknown(data['ayah']!, _ayahMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surah, ayah};
  @override
  SavedAyahRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedAyahRow(
      surah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah'],
      )!,
      ayah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $SavedAyahRowsTable createAlias(String alias) {
    return $SavedAyahRowsTable(attachedDatabase, alias);
  }
}

class SavedAyahRow extends DataClass implements Insertable<SavedAyahRow> {
  final int surah;
  final int ayah;
  final DateTime savedAt;
  const SavedAyahRow({
    required this.surah,
    required this.ayah,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah'] = Variable<int>(surah);
    map['ayah'] = Variable<int>(ayah);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  SavedAyahRowsCompanion toCompanion(bool nullToAbsent) {
    return SavedAyahRowsCompanion(
      surah: Value(surah),
      ayah: Value(ayah),
      savedAt: Value(savedAt),
    );
  }

  factory SavedAyahRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedAyahRow(
      surah: serializer.fromJson<int>(json['surah']),
      ayah: serializer.fromJson<int>(json['ayah']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surah': serializer.toJson<int>(surah),
      'ayah': serializer.toJson<int>(ayah),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  SavedAyahRow copyWith({int? surah, int? ayah, DateTime? savedAt}) =>
      SavedAyahRow(
        surah: surah ?? this.surah,
        ayah: ayah ?? this.ayah,
        savedAt: savedAt ?? this.savedAt,
      );
  SavedAyahRow copyWithCompanion(SavedAyahRowsCompanion data) {
    return SavedAyahRow(
      surah: data.surah.present ? data.surah.value : this.surah,
      ayah: data.ayah.present ? data.ayah.value : this.ayah,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedAyahRow(')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(surah, ayah, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedAyahRow &&
          other.surah == this.surah &&
          other.ayah == this.ayah &&
          other.savedAt == this.savedAt);
}

class SavedAyahRowsCompanion extends UpdateCompanion<SavedAyahRow> {
  final Value<int> surah;
  final Value<int> ayah;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const SavedAyahRowsCompanion({
    this.surah = const Value.absent(),
    this.ayah = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedAyahRowsCompanion.insert({
    required int surah,
    required int ayah,
    required DateTime savedAt,
    this.rowid = const Value.absent(),
  }) : surah = Value(surah),
       ayah = Value(ayah),
       savedAt = Value(savedAt);
  static Insertable<SavedAyahRow> custom({
    Expression<int>? surah,
    Expression<int>? ayah,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surah != null) 'surah': surah,
      if (ayah != null) 'ayah': ayah,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedAyahRowsCompanion copyWith({
    Value<int>? surah,
    Value<int>? ayah,
    Value<DateTime>? savedAt,
    Value<int>? rowid,
  }) {
    return SavedAyahRowsCompanion(
      surah: surah ?? this.surah,
      ayah: ayah ?? this.ayah,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surah.present) {
      map['surah'] = Variable<int>(surah.value);
    }
    if (ayah.present) {
      map['ayah'] = Variable<int>(ayah.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedAyahRowsCompanion(')
          ..write('surah: $surah, ')
          ..write('ayah: $ayah, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedAyahRowsTable savedAyahRows = $SavedAyahRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedAyahRows];
}

typedef $$SavedAyahRowsTableCreateCompanionBuilder =
    SavedAyahRowsCompanion Function({
      required int surah,
      required int ayah,
      required DateTime savedAt,
      Value<int> rowid,
    });
typedef $$SavedAyahRowsTableUpdateCompanionBuilder =
    SavedAyahRowsCompanion Function({
      Value<int> surah,
      Value<int> ayah,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });

class $$SavedAyahRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedAyahRowsTable> {
  $$SavedAyahRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedAyahRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedAyahRowsTable> {
  $$SavedAyahRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayah => $composableBuilder(
    column: $table.ayah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedAyahRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedAyahRowsTable> {
  $$SavedAyahRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surah =>
      $composableBuilder(column: $table.surah, builder: (column) => column);

  GeneratedColumn<int> get ayah =>
      $composableBuilder(column: $table.ayah, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SavedAyahRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedAyahRowsTable,
          SavedAyahRow,
          $$SavedAyahRowsTableFilterComposer,
          $$SavedAyahRowsTableOrderingComposer,
          $$SavedAyahRowsTableAnnotationComposer,
          $$SavedAyahRowsTableCreateCompanionBuilder,
          $$SavedAyahRowsTableUpdateCompanionBuilder,
          (
            SavedAyahRow,
            BaseReferences<_$AppDatabase, $SavedAyahRowsTable, SavedAyahRow>,
          ),
          SavedAyahRow,
          PrefetchHooks Function()
        > {
  $$SavedAyahRowsTableTableManager(_$AppDatabase db, $SavedAyahRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedAyahRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedAyahRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedAyahRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> surah = const Value.absent(),
                Value<int> ayah = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedAyahRowsCompanion(
                surah: surah,
                ayah: ayah,
                savedAt: savedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int surah,
                required int ayah,
                required DateTime savedAt,
                Value<int> rowid = const Value.absent(),
              }) => SavedAyahRowsCompanion.insert(
                surah: surah,
                ayah: ayah,
                savedAt: savedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SavedAyahRowsTable, SavedAyahRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SavedAyahRowsTable,
                    SavedAyahRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedAyahRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedAyahRowsTable,
      SavedAyahRow,
      $$SavedAyahRowsTableFilterComposer,
      $$SavedAyahRowsTableOrderingComposer,
      $$SavedAyahRowsTableAnnotationComposer,
      $$SavedAyahRowsTableCreateCompanionBuilder,
      $$SavedAyahRowsTableUpdateCompanionBuilder,
      (
        SavedAyahRow,
        BaseReferences<_$AppDatabase, $SavedAyahRowsTable, SavedAyahRow>,
      ),
      SavedAyahRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedAyahRowsTableTableManager get savedAyahRows =>
      $$SavedAyahRowsTableTableManager(_db, _db.savedAyahRows);
}
