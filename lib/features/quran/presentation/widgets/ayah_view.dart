import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../../i18n/strings.g.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/entities/quran_language.dart';
import '../../domain/quran_display.dart';

/// Arabic line, translation with footnote markers, and the ayah reference.
class AyahView extends StatelessWidget {
  const AyahView({
    required this.ayah,
    required this.language,
    required this.arabicStyle,
    required this.saved,
    required this.selected,
    required this.onTap,
    required this.onMarker,
    super.key,
  });

  final Ayah ayah;
  final QuranLanguage language;
  final TextStyle arabicStyle;
  final bool saved;
  final bool selected;
  final VoidCallback onTap;
  final ValueChanged<int> onMarker;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final translationStyle =
        (language.isRtl
                ? AppTextStyles.urduBody
                : AppTextStyles.readingSerifMedium)
            .copyWith(color: c.textPrimary);
    return Material(
      color: selected ? c.brandSoft : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.space12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text.rich(
                TextSpan(
                  style: arabicStyle.copyWith(color: c.textPrimary),
                  children: [
                    TextSpan(text: ayah.arabic),
                    TextSpan(
                      text: ' ﴿${arabicNumber(ayah.ref.ayah)}﴾',
                      style: arabicStyle.copyWith(color: c.accentDefault),
                    ),
                  ],
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: AppSpacing.space8),
              Text.rich(
                TextSpan(
                  style: translationStyle,
                  children: [
                    for (final piece in splitTranslation(ayah.translation))
                      switch (piece) {
                        TranslationTextPiece(:final text) => TextSpan(
                          text: text,
                        ),
                        TranslationMarkerPiece(:final marker) => WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: _Marker(
                            marker: marker,
                            onTap: () => onMarker(marker),
                          ),
                        ),
                      },
                  ],
                ),
                textDirection: language.isRtl
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
              const SizedBox(height: AppSpacing.space8),
              Row(
                children: [
                  Text(
                    context.t.quran.ayahLabel(ref: ayah.ref.key),
                    style: AppTextStyles.uiFootnote.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
                  if (saved) ...[
                    const SizedBox(width: AppSpacing.space4),
                    Icon(
                      Icons.favorite,
                      size: AppSizes.iconSizeSmall,
                      color: c.accentDefault,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Marker extends StatelessWidget {
  const _Marker({required this.marker, required this.onTap});

  final int marker;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.space4,
      ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          side: BorderSide(color: c.borderDefault, width: AppSizes.hairline),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.space4,
            ),
            child: Text(
              '$marker',
              style: AppTextStyles.uiCaptionEmphasized.copyWith(
                color: c.accentDefault,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
