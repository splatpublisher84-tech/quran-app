import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/design_system.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../domain/entities/arabic_text_size.dart';
import '../domain/entities/ayah.dart';
import '../domain/entities/ayah_ref.dart';
import '../domain/entities/quran_language.dart';
import '../domain/entities/saved_ayah.dart';
import '../domain/quran_display.dart';
import '../domain/quran_math.dart';
import '../domain/reader_blocks.dart';
import 'quran_providers.dart';
import 'reader_controller.dart';
import 'reading_settings_controller.dart';
import 'saved_ayahs_controller.dart';
import 'widgets/ayah_view.dart';
import 'widgets/quran_status.dart';

/// Reads one surah, or one Juz. [ayah] scrolls that ayah into view.
class ReaderScreen extends ConsumerWidget {
  const ReaderScreen.surah(this.surah, {this.ayah, super.key}) : juz = null;

  const ReaderScreen.juz(this.juz, {super.key}) : surah = null, ayah = null;

  final int? surah;
  final int? juz;
  final int? ayah;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (surah == null && juz == null) {
      return Scaffold(
        appBar: AppNavBar(title: context.t.quran.surah),
        body: QuranStatus(message: context.t.quran.loadError),
      );
    }

    final query = juz != null
        ? ReaderQuery.juz(juz!)
        : ReaderQuery.surah(surah!);
    final page = ref.watch(readerProvider(query));
    final settings = ref.watch(readingSettingsProvider);
    final t = context.t;

    ref.listen(readerProvider(query), (previous, next) {
      final document = next.value;
      if (document == null || previous?.value != null) return;
      final target = (surah != null && ayah != null)
          ? AyahRef(surah: surah!, ayah: ayah!)
          : firstAyahOf(document);
      if (target != null) {
        ref.read(readingSettingsProvider.notifier).remember(target);
      }
    });

    return Scaffold(
      appBar: AppNavBar(
        title: _title(t, page.value, juz),
        actions: [
          _LanguageButton(
            label: settings.language.name.toUpperCase(),
            semanticLabel: t.quran.translationLanguage,
            onPressed: () => _pickLanguage(context, ref),
          ),
          AppIconButton(
            icon: Icons.format_size_rounded,
            semanticLabel: t.quran.textSize,
            onPressed: () => _pickSize(context, ref),
          ),
        ],
      ),
      body: page.when(
        skipLoadingOnReload: true,
        loading: () => const QuranLoading(),
        error: (_, _) => QuranStatus(
          message: t.quran.loadError,
          onRetry: () => ref.invalidate(readerProvider(query)),
        ),
        data: (document) => _ReaderBody(
          document: document,
          initialAyah: (surah != null && ayah != null)
              ? AyahRef(surah: surah!, ayah: ayah!)
              : null,
          language: settings.language,
          arabicSize: settings.arabicSize,
        ),
      ),
    );
  }
}

String _title(Translations t, ReaderDocument? document, int? juz) {
  if (juz != null) return t.quran.juzTitle(n: juz);
  if (document != null) {
    for (final block in document.blocks) {
      if (block case SurahHeaderBlock(:final surah)) return surah.englishName;
    }
  }
  return t.quran.surah;
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.label,
    required this.semanticLabel,
    required this.onPressed,
  });

  final String label;
  final String semanticLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Tooltip(
      message: semanticLabel,
      child: Semantics(
        button: true,
        label: semanticLabel,
        child: Material(
          color: Colors.transparent,
          shape: CircleBorder(
            side: BorderSide(color: c.borderDefault, width: AppSizes.hairline),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: SizedBox.square(
              dimension: AppSizes.iconButton,
              child: Center(
                child: Text(
                  label,
                  style: AppTextStyles.uiCaptionEmphasized.copyWith(
                    color: c.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReaderBody extends ConsumerStatefulWidget {
  const _ReaderBody({
    required this.document,
    required this.initialAyah,
    required this.language,
    required this.arabicSize,
  });

  final ReaderDocument document;
  final AyahRef? initialAyah;
  final QuranLanguage language;
  final ArabicTextSize arabicSize;

  @override
  ConsumerState<_ReaderBody> createState() => _ReaderBodyState();
}

class _ReaderBodyState extends ConsumerState<_ReaderBody> {
  final _scroll = ScrollController();
  final _targetKey = GlobalKey();
  Ayah? _selected;
  var _placed = false;
  var _visible = false;

  @override
  void initState() {
    super.initState();
    _visible = widget.initialAyah == null;
    _schedulePlace();
  }

  @override
  void didUpdateWidget(_ReaderBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.document != widget.document ||
        oldWidget.initialAyah != widget.initialAyah) {
      _selected = null;
      _placed = false;
      _visible = widget.initialAyah == null;
      _schedulePlace();
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _schedulePlace() {
    if (widget.initialAyah == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => _stepTowardTarget());
  }

  void _stepTowardTarget() {
    if (!mounted || _placed) return;
    final target = _targetKey.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(target, alignment: 0.1);
      setState(() {
        _placed = true;
        _visible = true;
      });
      return;
    }
    if (!_scroll.hasClients) {
      _schedulePlace();
      return;
    }
    final position = _scroll.position;
    final next = (position.pixels + position.viewportDimension).clamp(
      0.0,
      position.maxScrollExtent,
    );
    if (next <= position.pixels + 1) {
      setState(() {
        _placed = true;
        _visible = true;
      });
      return;
    }
    _scroll.jumpTo(next);
    _schedulePlace();
  }

  TextStyle get _arabicStyle => switch (widget.arabicSize) {
    ArabicTextSize.small => AppTextStyles.arabicReaderSmall,
    ArabicTextSize.medium => AppTextStyles.arabicReaderMedium,
    ArabicTextSize.large => AppTextStyles.arabicReaderLarge,
  };

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(savedAyahsProvider);
    final blocks = widget.document.blocks;
    return Stack(
      children: [
        Opacity(
          opacity: _visible ? 1 : 0,
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.space16,
              AppSpacing.space8,
              AppSpacing.space16,
              AppSpacing.space48,
            ),
            itemCount: blocks.length + 1,
            itemBuilder: (context, index) {
              if (index == blocks.length) {
                return const SizedBox(height: AppSpacing.space48);
              }
              return _block(context, blocks[index], saved);
            },
          ),
        ),
        if (!_visible) const QuranLoading(),
        if (_selected != null)
          PositionedDirectional(
            start: AppSpacing.space16,
            end: AppSpacing.space16,
            bottom: AppSpacing.space16,
            child: _ActionBar(
              ayah: _selected!,
              saved: ref
                  .read(savedAyahsProvider.notifier)
                  .isSaved(_selected!.ref),
              onSave: () =>
                  ref.read(savedAyahsProvider.notifier).toggle(_selected!),
              onShare: () => showAppToast(context, context.t.quran.shareLater),
              onClose: () => setState(() => _selected = null),
            ),
          ),
      ],
    );
  }

  Widget _block(
    BuildContext context,
    ReaderBlock block,
    AsyncValue<List<SavedAyah>> saved,
  ) {
    final c = context.colors;
    return switch (block) {
      SurahHeaderBlock(:final surah) => Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.space16,
        ),
        child: Column(
          children: [
            Text(
              surah.displayArabicName,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppTextStyles.arabicReaderSmall.copyWith(
                color: c.textPrimary,
              ),
            ),
            Text(
              surah.englishName,
              textAlign: TextAlign.center,
              style: AppTextStyles.uiHeadingSmall.copyWith(
                color: c.textPrimary,
              ),
            ),
            Text(
              surah.meaning,
              textAlign: TextAlign.center,
              style: AppTextStyles.uiFootnote.copyWith(color: c.textSecondary),
            ),
          ],
        ),
      ),
      BasmalaBlock() => Padding(
        padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.space12),
        child: Text(
          basmalaText,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyles.arabicBasmala.copyWith(color: c.textPrimary),
        ),
      ),
      AyahBlock(:final ayah) => Padding(
        key: ayah.ref == widget.initialAyah ? _targetKey : null,
        padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.space8),
        child: AyahView(
          ayah: ayah,
          language: widget.language,
          arabicStyle: _arabicStyle,
          saved: _isSaved(saved, ayah.ref),
          selected: _selected?.ref == ayah.ref,
          onTap: () {
            setState(() {
              _selected = _selected?.ref == ayah.ref ? null : ayah;
            });
            ref.read(readingSettingsProvider.notifier).remember(ayah.ref);
          },
          onMarker: (marker) => _showNote(context, ayah, marker),
        ),
      ),
      AttributionBlock(:final text) => Padding(
        padding: const EdgeInsetsDirectional.only(top: AppSpacing.space24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.uiFootnote.copyWith(color: c.textSecondary),
        ),
      ),
    };
  }

  bool _isSaved(AsyncValue<List<SavedAyah>> saved, AyahRef ayah) {
    final items = saved.value;
    if (items == null) return false;
    for (final item in items) {
      if (item.ref == ayah) return true;
    }
    return false;
  }
}

void _showNote(BuildContext context, Ayah ayah, int marker) {
  final notes = parseFootnotes(ayah.footnotes);
  var text = '';
  for (final note in notes) {
    if (note.marker == marker) {
      text = note.text;
      break;
    }
  }
  showAppBottomSheet<void>(
    context: context,
    builder: (sheetContext) {
      final c = sheetContext.colors;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sheetContext.t.quran.translatorNote,
            style: AppTextStyles.uiHeadingSmall.copyWith(color: c.textPrimary),
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            text,
            style: AppTextStyles.readingSerifSmall.copyWith(
              color: c.textPrimary,
            ),
          ),
        ],
      );
    },
  );
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.ayah,
    required this.saved,
    required this.onSave,
    required this.onShare,
    required this.onClose,
  });

  final Ayah ayah;
  final bool saved;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.t;
    return Material(
      color: c.backgroundDefault,
      shape: StadiumBorder(
        side: BorderSide(color: c.borderDefault, width: AppSizes.hairline),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: AppSpacing.space16,
          end: AppSpacing.space4,
        ),
        child: Row(
          children: [
            Text(
              ayah.ref.key,
              style: AppTextStyles.uiFootnote.copyWith(color: c.textSecondary),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: onSave,
              icon: Icon(
                saved ? Icons.favorite : Icons.favorite_border,
                color: saved ? c.accentDefault : c.textPrimary,
              ),
              label: Text(saved ? t.quran.saved : t.quran.save),
              style: TextButton.styleFrom(
                foregroundColor: saved ? c.accentDefault : c.textPrimary,
                textStyle: AppTextStyles.uiLabelEmphasized,
              ),
            ),
            TextButton.icon(
              onPressed: onShare,
              icon: Icon(Icons.ios_share, color: c.textPrimary),
              label: Text(t.quran.share),
              style: TextButton.styleFrom(
                foregroundColor: c.textPrimary,
                textStyle: AppTextStyles.uiLabelEmphasized,
              ),
            ),
            AppIconButton(
              icon: Icons.close_rounded,
              semanticLabel: t.common.close,
              variant: AppIconButtonVariant.filled,
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _pickLanguage(BuildContext context, WidgetRef ref) async {
  final result = await ref.read(getTranslationsProvider)();
  final translations = result.valueOrNull;
  if (translations == null || !context.mounted) return;
  final current = ref.read(readingSettingsProvider).language;
  await showAppBottomSheet<void>(
    context: context,
    builder: (sheetContext) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sheetContext.t.quran.translationLanguage,
            style: AppTextStyles.uiHeadingSmall.copyWith(
              color: sheetContext.colors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          for (final item in translations)
            _ChoiceRow(
              title: _languageLabel(sheetContext.t, item.language),
              subtitle: item.title,
              selected: item.language == current,
              onTap: () async {
                await ref
                    .read(readingSettingsProvider.notifier)
                    .setLanguage(item.language);
                if (sheetContext.mounted) Navigator.of(sheetContext).pop();
              },
            ),
        ],
      );
    },
  );
}

Future<void> _pickSize(BuildContext context, WidgetRef ref) {
  final current = ref.read(readingSettingsProvider).arabicSize;
  return showAppBottomSheet<void>(
    context: context,
    builder: (sheetContext) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sheetContext.t.quran.arabicTextSize,
            style: AppTextStyles.uiHeadingSmall.copyWith(
              color: sheetContext.colors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          for (final size in ArabicTextSize.values)
            _ChoiceRow(
              title: _sizeLabel(sheetContext.t, size),
              selected: size == current,
              onTap: () async {
                await ref
                    .read(readingSettingsProvider.notifier)
                    .setArabicSize(size);
                if (sheetContext.mounted) Navigator.of(sheetContext).pop();
              },
            ),
        ],
      );
    },
  );
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.space12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.uiBodyRegular.copyWith(
                      color: c.textPrimary,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTextStyles.uiFootnote.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (selected) Icon(Icons.check_rounded, color: c.brandDefault),
          ],
        ),
      ),
    );
  }
}

String _languageLabel(Translations t, QuranLanguage language) =>
    switch (language) {
      QuranLanguage.en => t.quran.languageEn,
      QuranLanguage.id => t.quran.languageId,
      QuranLanguage.ur => t.quran.languageUr,
      QuranLanguage.tr => t.quran.languageTr,
    };

String _sizeLabel(Translations t, ArabicTextSize size) => switch (size) {
  ArabicTextSize.small => t.quran.small,
  ArabicTextSize.medium => t.quran.medium,
  ArabicTextSize.large => t.quran.large,
};
