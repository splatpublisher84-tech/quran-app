import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Large screen title with optional subtitle and trailing action.
class AppLargeHeader extends StatelessWidget {
  const AppLargeHeader({
    required this.title,
    this.subtitle,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.uiHeadingLarge.copyWith(
                  color: c.textPrimary,
                ),
              ),
              if (subtitle case final text?) ...[
                const SizedBox(height: AppSpacing.space8),
                Text(
                  text,
                  style: AppTextStyles.uiBodyRegular.copyWith(
                    color: c.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
