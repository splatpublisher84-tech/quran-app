import 'entities/juz.dart';
import 'entities/saved_ayah.dart';
import 'entities/surah.dart';

/// Surahs whose number, English name, meaning or Arabic name matches [query].
List<Surah> filterSurahs(List<Surah> surahs, String query) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return surahs;
  final q = trimmed.toLowerCase();
  final asNumber = int.tryParse(trimmed);
  return [
    for (final surah in surahs)
      if (surah.number == asNumber ||
          surah.englishName.toLowerCase().contains(q) ||
          surah.meaning.toLowerCase().contains(q) ||
          surah.displayArabicName.contains(trimmed))
        surah,
  ];
}

/// Juz whose number or starting surah name matches [query].
List<Juz> filterJuzs({
  required List<Juz> juzs,
  required List<Surah> surahs,
  required String query,
}) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return juzs;
  final q = trimmed.toLowerCase();
  final asNumber = int.tryParse(trimmed);
  return [
    for (final juz in juzs)
      if (juz.number == asNumber ||
          surahs[juz.start.surah - 1].englishName.toLowerCase().contains(q))
        juz,
  ];
}

/// Saved ayahs whose reference, Arabic or translation matches [query].
List<SavedAyah> filterSavedAyahs(List<SavedAyah> items, String query) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return items;
  final q = trimmed.toLowerCase();
  return [
    for (final item in items)
      if (item.ref.key.contains(trimmed) ||
          item.arabic.contains(trimmed) ||
          item.translation.toLowerCase().contains(q))
        item,
  ];
}
