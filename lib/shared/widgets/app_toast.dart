import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Floating message with an optional action, such as Undo.
void showAppToast(
  BuildContext context,
  String message, {
  String? actionLabel,
  VoidCallback? onAction,
}) {
  final c = context.colors;
  final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: c.toastBackground,
      margin: const EdgeInsets.all(AppSpacing.space16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      content: Text(
        message,
        style: AppTextStyles.uiBodyRegular.copyWith(color: c.textPrimary),
      ),
      action: actionLabel == null
          ? null
          : SnackBarAction(
              label: actionLabel,
              textColor: c.accentDefault,
              onPressed: onAction ?? () {},
            ),
    ),
  );
}
