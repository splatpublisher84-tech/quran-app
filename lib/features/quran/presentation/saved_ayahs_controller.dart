import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/infrastructure_providers.dart';
import '../domain/entities/ayah.dart';
import '../domain/entities/ayah_ref.dart';
import '../domain/entities/saved_ayah.dart';
import 'quran_providers.dart';
import 'reading_settings_controller.dart';

class SavedAyahsController extends AsyncNotifier<List<SavedAyah>> {
  @override
  Future<List<SavedAyah>> build() async {
    final language = ref.watch(
      readingSettingsProvider.select((settings) => settings.language),
    );
    final result = await ref.watch(getSavedAyahsProvider)(language);
    final items = result.valueOrNull;
    if (items == null) throw result.failureOrNull!;
    return items;
  }

  bool isSaved(AyahRef ayah) =>
      state.value?.any((item) => item.ref == ayah) ?? false;

  Future<void> toggle(Ayah ayah) async {
    final current = state.value;
    if (current == null) return;
    final saved = current.any((item) => item.ref == ayah.ref);
    final result = await ref.read(toggleSavedAyahProvider)(
      ayah.ref,
      saved: saved,
    );
    if (!result.isOk || !ref.mounted) return;
    if (saved) {
      state = AsyncData([
        for (final item in current)
          if (item.ref != ayah.ref) item,
      ]);
      return;
    }
    state = AsyncData([
      SavedAyah(
        ref: ayah.ref,
        savedAt: ref.read(clockProvider).now(),
        arabic: ayah.arabic,
        translation: ayah.translation,
      ),
      ...current,
    ]);
  }
}

final savedAyahsProvider =
    AsyncNotifierProvider<SavedAyahsController, List<SavedAyah>>(
      SavedAyahsController.new,
    );
