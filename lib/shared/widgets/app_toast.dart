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
      backgroundColor: c.textPrimary,
      margin: const EdgeInsets.all(AppSpacing.space16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      content: Text(
        message,
        style: AppTextStyles.uiBody.copyWith(color: c.background),
      ),
      action: actionLabel == null
          ? null
          : SnackBarAction(label: actionLabel, onPressed: onAction ?? () {}),
    ),
  );
}
