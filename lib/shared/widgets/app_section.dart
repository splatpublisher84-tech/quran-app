import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Grouped card with optional uppercase title. Rows inside are divided by
/// hairlines.
class AppSection extends StatelessWidget {
  const AppSection({required this.children, this.title, super.key});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i < children.length - 1) {
        items.add(
          Divider(
            height: AppSizes.hairline,
            thickness: AppSizes.hairline,
            indent: AppSpacing.space16,
            color: c.borderSubtle,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title case final text?)
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.space16,
              bottom: AppSpacing.space8,
            ),
            child: Text(
              text.toUpperCase(),
              style: AppTextStyles.uiFootnoteUppercase.copyWith(
                color: c.textSecondary,
              ),
            ),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: c.groupBackground,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: c.borderDefault,
              width: AppSizes.hairline,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Column(children: items),
          ),
        ),
      ],
    );
  }
}

/// One row inside an [AppSection].
class AppRow extends StatelessWidget {
  const AppRow({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        child: Row(
          children: [
            if (leading case final icon?) ...[
              Icon(icon, size: AppSizes.iconSize, color: c.brandDefault),
              const SizedBox(width: AppSpacing.space12),
            ],
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
                  if (subtitle case final text?)
                    Text(
                      text,
                      style: AppTextStyles.uiCaptionRegular.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing case final widget?)
              widget
            else if (onTap != null)
              Icon(
                Icons.chevron_right_rounded,
                size: AppSizes.iconSize,
                color: c.textSecondary,
              ),
          ],
        ),
      ),
    );
  }
}
