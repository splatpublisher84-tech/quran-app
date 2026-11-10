/// Arabic type size in the reader. The translation size does not follow this.
enum ArabicTextSize {
  small,
  medium,
  large;

  static const ArabicTextSize fallback = ArabicTextSize.medium;

  static ArabicTextSize fromCode(String? code) {
    for (final size in ArabicTextSize.values) {
      if (size.name == code) return size;
    }
    return fallback;
  }
}
