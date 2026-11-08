import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';
import 'app_button.dart';

/// Confirm dialog. Resolves to `true` when confirmed, `false` when cancelled,
/// and `null` when dismissed.
Future<bool?> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
}) {
  final c = context.colors;
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: c.dialogBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      title: Text(
        title,
        style: AppTextStyles.uiHeadingMedium.copyWith(color: c.textPrimary),
      ),
      content: Text(
        message,
        style: AppTextStyles.uiBodyRegular.copyWith(color: c.textSecondary),
      ),
      actions: [
        AppButton(
          label: cancelLabel,
          variant: AppButtonVariant.text,
          onPressed: () => Navigator.of(dialogContext).pop(false),
        ),
        AppButton(
          label: confirmLabel,
          variant: AppButtonVariant.text,
          onPressed: () => Navigator.of(dialogContext).pop(true),
        ),
      ],
    ),
  );
}
