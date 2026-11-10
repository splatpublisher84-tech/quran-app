import '../../../../core/error/result.dart';
import '../entities/ayah.dart';
import '../entities/ayah_ref.dart';
import '../entities/quran_language.dart';
import '../entities/saved_ayah.dart';
import '../repositories/quran_repository.dart';
import '../repositories/saved_ayah_repository.dart';

/// Saved ayahs with Arabic and the current translation filled in.
class GetSavedAyahs {
  const GetSavedAyahs(this._quran, this._saved);

  final QuranRepository _quran;
  final SavedAyahRepository _saved;

  Future<Result<List<SavedAyah>>> call(QuranLanguage language) async {
    final saved = await _saved.getAll();
    final records = saved.valueOrNull;
    if (records == null) return Err(saved.failureOrNull!);

    final cache = <int, List<Ayah>>{};
    final items = <SavedAyah>[];
    for (final record in records) {
      final loaded = cache[record.ref.surah];
      final List<Ayah> ayahs;
      if (loaded != null) {
        ayahs = loaded;
      } else {
        final result = await _quran.getAyahs(
          surahNumber: record.ref.surah,
          language: language,
        );
        final value = result.valueOrNull;
        if (value == null) return Err(result.failureOrNull!);
        cache[record.ref.surah] = value;
        ayahs = value;
      }
      Ayah? match;
      for (final ayah in ayahs) {
        if (ayah.ref.ayah == record.ref.ayah) {
          match = ayah;
          break;
        }
      }
      if (match == null) continue;
      items.add(
        SavedAyah(
          ref: record.ref,
          savedAt: record.savedAt,
          arabic: match.arabic,
          translation: match.translation,
        ),
      );
    }
    return Ok(items);
  }
}

/// Saves [ref] when [saved] is false, and removes it when [saved] is true.
/// The returned bool is the state after the change.
class ToggleSavedAyah {
  const ToggleSavedAyah(this._saved);

  final SavedAyahRepository _saved;

  Future<Result<bool>> call(AyahRef ref, {required bool saved}) async {
    final result = saved ? await _saved.remove(ref) : await _saved.save(ref);
    if (!result.isOk) return Err(result.failureOrNull!);
    return Ok(!saved);
  }
}
