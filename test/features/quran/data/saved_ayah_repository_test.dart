import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/platform/clock.dart';
import 'package:quran_app/core/storage/app_database.dart';
import 'package:quran_app/features/quran/data/repositories/saved_ayah_repository_impl.dart';
import 'package:quran_app/features/quran/domain/entities/ayah_ref.dart';

void main() {
  test('save, list newest first, and remove', () async {
    final clock = _Clock();
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repo = SavedAyahRepositoryImpl(database, clock);

    const older = AyahRef(surah: 1, ayah: 1);
    const newer = AyahRef(surah: 112, ayah: 1);
    expect((await repo.save(older)).isOk, isTrue);
    clock.current = clock.current.add(const Duration(seconds: 1));
    expect((await repo.save(newer)).isOk, isTrue);
    expect((await repo.save(newer)).isOk, isTrue);

    final listed = (await repo.getAll()).valueOrNull!;
    expect(listed.map((item) => item.ref).toList(), [newer, older]);

    expect((await repo.remove(newer)).isOk, isTrue);
    final left = (await repo.getAll()).valueOrNull!;
    expect(left.single.ref, older);
  });
}

class _Clock implements AppClock {
  DateTime current = DateTime.utc(2026, 1, 1);

  @override
  DateTime now() => current;
}
