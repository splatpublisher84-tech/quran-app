import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../../i18n/strings.g.dart';
import '../../../../shared/widgets/shared_widgets.dart';

/// Centered message for a loading failure, with an optional retry.
class QuranStatus extends StatelessWidget {
  const QuranStatus({required this.message, this.onRetry, super.key});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.uiBodyRegular.copyWith(
                color: c.textSecondary,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.space16),
              AppButton(
                label: context.t.common.retry,
                onPressed: onRetry,
                variant: AppButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class QuranLoading extends StatelessWidget {
  const QuranLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.t.quran.loading,
        style: AppTextStyles.uiBodyRegular.copyWith(
          color: context.colors.textSecondary,
        ),
      ),
    );
  }
}
