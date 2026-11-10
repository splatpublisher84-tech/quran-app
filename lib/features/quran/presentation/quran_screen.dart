import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/design_system/design_system.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../domain/entities/ayah_ref.dart';
import '../domain/entities/juz.dart';
import '../domain/entities/quran_catalog.dart';
import '../domain/entities/quran_language.dart';
import '../domain/entities/reading_settings.dart';
import '../domain/entities/saved_ayah.dart';
import '../domain/entities/surah.dart';
import '../domain/quran_display.dart';
import '../domain/quran_math.dart';
import '../domain/quran_search.dart';
import 'quran_catalog_controller.dart';
import 'reading_settings_controller.dart';
import 'saved_ayahs_controller.dart';
import 'widgets/quran_status.dart';

enum _Browse { surah, juz }

/// Quran tab: search, Surah or Juz, and continue reading.
class QuranScreen extends ConsumerStatefulWidget {
  const QuranScreen({super.key});

  @override
  ConsumerState<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends ConsumerState<QuranScreen> {
  final _query = TextEditingController();
  _Browse _browse = _Browse.surah;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(quranCatalogProvider);
    final settings = ref.watch(readingSettingsProvider);

    return Scaffold(
      body: SafeArea(
        child: catalog.when(
          loading: () => const QuranLoading(),
          error: (_, _) => QuranStatus(
            message: context.t.quran.loadError,
            onRetry: () => ref.invalidate(quranCatalogProvider),
          ),
          data: (data) => _IndexBody(
            catalog: data,
            settings: settings,
            query: _query,
            browse: _browse,
            onQueryChanged: () => setState(() {}),
            onBrowseChanged: (browse) => setState(() => _browse = browse),
          ),
        ),
      ),
    );
  }
}

class _IndexBody extends StatelessWidget {
  const _IndexBody({
    required this.catalog,
    required this.settings,
    required this.query,
    required this.browse,
    required this.onQueryChanged,
    required this.onBrowseChanged,
  });

  final QuranCatalog catalog;
  final ReadingSettings settings;
  final TextEditingController query;
  final _Browse browse;
  final VoidCallback onQueryChanged;
  final ValueChanged<_Browse> onBrowseChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final text = query.text;
    final parsed = parseAyahReference(text, catalog.surahs);
    final last = settings.lastRead;
    final continueSurah = _continueSurah(catalog, last);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.space16,
            AppSpacing.space16,
            AppSpacing.space16,
            AppSpacing.space12,
          ),
          child: AppLargeHeader(
            title: t.quran.title,
            trailing: AppIconButton(
              icon: Icons.favorite_border,
              semanticLabel: t.quran.saved,
              variant: AppIconButtonVariant.filled,
              onPressed: () => context.push(AppRoutes.quranSaved),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.space16,
          ),
          child: _SearchField(controller: query, onChanged: onQueryChanged),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.space16,
            AppSpacing.space12,
            AppSpacing.space16,
            AppSpacing.space8,
          ),
          child: AppSegmented<_Browse>(
            options: [
              AppSegmentOption(value: _Browse.surah, label: t.quran.surah),
              AppSegmentOption(value: _Browse.juz, label: t.quran.juz),
            ],
            selected: browse,
            onChanged: onBrowseChanged,
          ),
        ),
        if (continueSurah != null && last != null) ...[
          const SizedBox(height: AppSpacing.space4),
          _ContinueReading(
            surah: continueSurah,
            ayah: last,
            onTap: () =>
                context.push(AppRoutes.quranSurah(last.surah, ayah: last.ayah)),
          ),
        ],
        Expanded(
          child: parsed != null
              ? _GoToList(
                  ref: parsed,
                  onTap: () => context.push(
                    AppRoutes.quranSurah(parsed.surah, ayah: parsed.ayah),
                  ),
                )
              : switch (browse) {
                  _Browse.surah => _SurahList(
                    surahs: filterSurahs(catalog.surahs, text),
                    onTap: (surah) =>
                        context.push(AppRoutes.quranSurah(surah.number)),
                  ),
                  _Browse.juz => _JuzList(
                    juzs: filterJuzs(
                      juzs: catalog.juzs,
                      surahs: catalog.surahs,
                      query: text,
                    ),
                    surahs: catalog.surahs,
                    onTap: (juz) =>
                        context.push(AppRoutes.quranJuz(juz.number)),
                  ),
                },
        ),
      ],
    );
  }
}

/// Saved ayahs, opened from the heart on the Quran header.
class SavedAyahsScreen extends ConsumerWidget {
  const SavedAyahsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedAyahsProvider);
    final language = ref.watch(
      readingSettingsProvider.select((settings) => settings.language),
    );
    return Scaffold(
      appBar: AppNavBar(title: context.t.quran.saved),
      body: _SavedList(
        saved: saved,
        query: '',
        language: language,
        onRetry: () => ref.invalidate(savedAyahsProvider),
        onTap: (item) => context.push(
          AppRoutes.quranSurah(item.ref.surah, ayah: item.ref.ayah),
        ),
      ),
    );
  }
}

Surah? _continueSurah(QuranCatalog catalog, AyahRef? last) {
  if (last == null) return null;
  if (last.surah < 1 || last.surah > catalog.surahs.length) return null;
  return catalog.surahs[last.surah - 1];
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.t;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          height: AppSizes.iconButton,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.space12,
          ),
          decoration: BoxDecoration(
            color: c.groupBackground,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: AppSizes.iconSize,
                color: c.textSecondary,
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (_) => onChanged(),
                  textInputAction: TextInputAction.search,
                  style: AppTextStyles.uiBodyRegular.copyWith(
                    color: c.textPrimary,
                  ),
                  cursorColor: c.brandDefault,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: t.quran.searchHint,
                    hintStyle: AppTextStyles.uiBodyRegular.copyWith(
                      color: c.textSecondary,
                    ),
                  ),
                ),
              ),
              if (controller.text.isNotEmpty)
                AppIconButton(
                  icon: Icons.close_rounded,
                  semanticLabel: t.quran.clear,
                  onPressed: () {
                    controller.clear();
                    onChanged();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ContinueReading extends StatelessWidget {
  const _ContinueReading({
    required this.surah,
    required this.ayah,
    required this.onTap,
  });

  final Surah surah;
  final AyahRef ayah;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.space16,
      ),
      child: Material(
        color: c.brandSoft,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(AppSpacing.space16),
            child: Row(
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: c.buttonPrimary,
                  size: AppSizes.iconSize,
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.t.quran.continueReading,
                        style: AppTextStyles.uiBodyEmphasized.copyWith(
                          color: c.textPrimary,
                        ),
                      ),
                      Text(
                        '${surah.englishName} ${ayah.key}',
                        style: AppTextStyles.uiFootnote.copyWith(
                          color: c.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoToList extends StatelessWidget {
  const _GoToList({required this.ref, required this.onTap});

  final AyahRef ref;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.space16,
      ),
      children: [
        _IndexTile(
          title: context.t.quran.goTo(ref: ref.key),
          subtitle: context.t.quran.ayahLabel(ref: ref.key),
          onTap: onTap,
        ),
      ],
    );
  }
}

class _SurahList extends StatelessWidget {
  const _SurahList({required this.surahs, required this.onTap});

  final List<Surah> surahs;
  final ValueChanged<Surah> onTap;

  @override
  Widget build(BuildContext context) {
    if (surahs.isEmpty) {
      return QuranStatus(message: context.t.quran.noSurahFound);
    }
    return ListView.builder(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.space16,
      ),
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        return _IndexTile(
          title: surah.englishName,
          subtitle:
              '${surah.meaning}, ${context.t.quran.ayahCount(n: surah.ayahCount)}',
          trailing: surah.displayArabicName,
          badge: '${surah.number}',
          onTap: () => onTap(surah),
        );
      },
    );
  }
}

class _JuzList extends StatelessWidget {
  const _JuzList({
    required this.juzs,
    required this.surahs,
    required this.onTap,
  });

  final List<Juz> juzs;
  final List<Surah> surahs;
  final ValueChanged<Juz> onTap;

  @override
  Widget build(BuildContext context) {
    if (juzs.isEmpty) {
      return QuranStatus(message: context.t.quran.noJuzFound);
    }
    return ListView.builder(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.space16,
      ),
      itemCount: juzs.length,
      itemBuilder: (context, index) {
        final juz = juzs[index];
        final surah = surahs[juz.start.surah - 1];
        return _IndexTile(
          title: context.t.quran.juzTitle(n: juz.number),
          subtitle: '${surah.englishName} ${juz.start.key}',
          badge: '${juz.number}',
          onTap: () => onTap(juz),
        );
      },
    );
  }
}

class _SavedList extends StatelessWidget {
  const _SavedList({
    required this.saved,
    required this.query,
    required this.language,
    required this.onRetry,
    required this.onTap,
  });

  final AsyncValue<List<SavedAyah>> saved;
  final String query;
  final QuranLanguage language;
  final VoidCallback onRetry;
  final ValueChanged<SavedAyah> onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return saved.when(
      loading: () => const QuranLoading(),
      error: (_, _) =>
          QuranStatus(message: t.quran.loadError, onRetry: onRetry),
      data: (items) {
        final visible = filterSavedAyahs(items, query);
        if (items.isEmpty) {
          return QuranStatus(
            message: '${t.quran.noSaved}\n${t.quran.noSavedHint}',
          );
        }
        if (visible.isEmpty) {
          return QuranStatus(message: t.quran.noResults);
        }
        return ListView.builder(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.space16,
            AppSpacing.space8,
            AppSpacing.space16,
            AppSpacing.space24,
          ),
          itemCount: visible.length,
          itemBuilder: (context, index) {
            final item = visible[index];
            return Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: AppSpacing.space12,
              ),
              child: _SavedCard(
                item: item,
                language: language,
                onTap: () => onTap(item),
              ),
            );
          },
        );
      },
    );
  }
}

class _SavedCard extends StatelessWidget {
  const _SavedCard({
    required this.item,
    required this.language,
    required this.onTap,
  });

  final SavedAyah item;
  final QuranLanguage language;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final translationStyle = language.isRtl
        ? AppTextStyles.urduBody
        : AppTextStyles.readingSerifSmall;
    return Material(
      color: c.groupBackground,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.ref.key,
                style: AppTextStyles.uiFootnote.copyWith(
                  color: c.accentDefault,
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                item.arabic,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: AppTextStyles.arabicLabel.copyWith(color: c.textPrimary),
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                translationPreview(item.translation),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textDirection: language.isRtl
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: translationStyle.copyWith(color: c.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndexTile extends StatelessWidget {
  const _IndexTile({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing,
    this.badge,
  });

  final String title;
  final String? subtitle;
  final String? trailing;
  final String? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.space12,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: c.borderSubtle, width: AppSizes.hairline),
          ),
        ),
        child: Row(
          children: [
            if (badge != null) ...[
              _Badge(label: badge!),
              const SizedBox(width: AppSpacing.space12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.uiBodyEmphasized.copyWith(
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
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.space12),
              Text(
                trailing!,
                style: AppTextStyles.arabicLabel.copyWith(color: c.textPrimary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: AppSpacing.space32,
      height: AppSpacing.space32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: c.accentDefault.withValues(alpha: 0.12),
      ),
      child: Text(
        label,
        style: AppTextStyles.uiCaptionEmphasized.copyWith(
          color: c.accentDefault,
        ),
      ),
    );
  }
}
