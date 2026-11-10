import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/app_preferences.dart';
import '../domain/entities/arabic_text_size.dart';
import '../domain/entities/ayah_ref.dart';
import '../domain/entities/quran_language.dart';
import '../domain/entities/reading_settings.dart';

/// Translation language, Arabic size and the last opened ayah.
class ReadingSettingsController extends Notifier<ReadingSettings> {
  @override
  ReadingSettings build() {
    final prefs = ref.watch(appPreferencesProvider);
    return ReadingSettings(
      language:
          QuranLanguage.tryParse(prefs.quranLanguageCode) ??
          QuranLanguage.fromCode(
            PlatformDispatcher.instance.locale.languageCode,
          ),
      arabicSize: ArabicTextSize.fromCode(prefs.arabicTextSizeCode),
      lastRead: AyahRef.tryParseKey(prefs.lastRead),
    );
  }

  Future<void> setLanguage(QuranLanguage language) async {
    await ref.read(appPreferencesProvider).setQuranLanguageCode(language.name);
    state = state.copyWith(language: language);
  }

  Future<void> setArabicSize(ArabicTextSize size) async {
    await ref.read(appPreferencesProvider).setArabicTextSizeCode(size.name);
    state = state.copyWith(arabicSize: size);
  }

  Future<void> remember(AyahRef ayah) async {
    if (state.lastRead == ayah) return;
    await ref.read(appPreferencesProvider).setLastRead(ayah.key);
    state = state.copyWith(lastRead: ayah);
  }
}

final readingSettingsProvider =
    NotifierProvider<ReadingSettingsController, ReadingSettings>(
      ReadingSettingsController.new,
    );
