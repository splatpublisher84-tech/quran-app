/// Translation languages shipped in v1. Vietnamese is not part of the v1 scope.
enum QuranLanguage {
  en,
  id,
  ur,
  tr;

  /// Right to left script. The reader must lay out this translation RTL.
  bool get isRtl => this == QuranLanguage.ur;

  static const QuranLanguage fallback = QuranLanguage.en;

  /// Supported language for [code], or null when the code is not supported.
  static QuranLanguage? tryParse(String? code) {
    for (final lang in QuranLanguage.values) {
      if (lang.name == code) return lang;
    }
    return null;
  }

  /// Supported language for a device language code, or [fallback].
  static QuranLanguage fromCode(String? code) => tryParse(code) ?? fallback;
}
