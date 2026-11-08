import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Shows a themed modal bottom sheet with the drag handle and rounded top.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  final c = context.colors;
  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    backgroundColor: c.backgroundSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpacing.space24,
          right: AppSpacing.space24,
          bottom: AppSpacing.space24,
        ),
        child: builder(sheetContext),
      ),
    ),
  );
}
