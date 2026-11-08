import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Visual style of an [AppIconButton], from `dev-handoff/02-ui-spec` (`.iconBtn-*`).
enum AppIconButtonVariant { plain, filled, outline, glass }

/// Round icon button, 44 pt, with a required label for screen readers.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    this.variant = AppIconButtonVariant.plain,
    super.key,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (bg, fg, border) = switch (variant) {
      AppIconButtonVariant.plain => (
        Colors.transparent,
        c.textPrimary,
        Colors.transparent,
      ),
      AppIconButtonVariant.filled => (
        c.groupBackground,
        c.textPrimary,
        Colors.transparent,
      ),
      AppIconButtonVariant.outline => (
        Colors.transparent,
        c.textPrimary,
        c.borderDefault,
      ),
      AppIconButtonVariant.glass => (
        c.buttonGlass,
        c.cardText,
        c.buttonGlassBorder,
      ),
    };

    return Tooltip(
      message: semanticLabel,
      child: Semantics(
        button: true,
        enabled: onPressed != null,
        label: semanticLabel,
        child: Material(
          color: bg,
          shape: CircleBorder(
            side: border == Colors.transparent
                ? BorderSide.none
                : BorderSide(color: border, width: AppSizes.hairline),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: SizedBox.square(
              dimension: AppSizes.iconButton,
              child: Icon(icon, size: AppSizes.iconSize, color: fg),
            ),
          ),
        ),
      ),
    );
  }
}
