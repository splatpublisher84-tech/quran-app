/// Route paths. Keep every path string in this file.
abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const quran = '/quran';
  static const ayahOfDay = '/ayah-of-the-day';
  static const settings = '/settings';

  static String quranSurah(int surah, {int? ayah}) {
    final path = '$quran/surah/$surah';
    if (ayah == null) return path;
    return '$path?ayah=$ayah';
  }

  static String quranJuz(int juz) => '$quran/juz/$juz';

  static const quranSaved = '$quran/saved';
}
