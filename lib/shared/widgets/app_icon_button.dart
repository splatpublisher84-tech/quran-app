import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Square icon button with a required label for screen readers.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: semanticLabel,
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(
        width: AppSizes.iconButton,
        height: AppSizes.iconButton,
      ),
      icon: Icon(
        icon,
        size: AppSizes.iconSize,
        color: context.colors.textPrimary,
      ),
    );
  }
}
