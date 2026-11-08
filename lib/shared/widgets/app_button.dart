import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

enum AppButtonVariant {
  primary,
  secondary,
  tertiary,
  inverse,
  glass,
  outline,
  text,
}

/// Pill button. The variant picks colors from `AppColors`.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;

  /// When true the button stretches to the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (bg, fg, border) = switch (variant) {
      AppButtonVariant.primary => (c.buttonPrimary, c.textInverse, null),
      AppButtonVariant.secondary => (c.buttonSecondary, c.textPrimary, null),
      AppButtonVariant.tertiary => (c.accentDefault, c.textInverse, null),
      AppButtonVariant.inverse => (c.buttonInverse, c.brandDefault, null),
      AppButtonVariant.glass => (
        c.buttonGlass,
        c.cardText,
        c.buttonGlassBorder,
      ),
      AppButtonVariant.outline => (
        Colors.transparent,
        c.textPrimary,
        c.textPrimary.withValues(alpha: 0.4),
      ),
      AppButtonVariant.text => (Colors.transparent, c.textSecondary, null),
    };
    final isText = variant == AppButtonVariant.text;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: AppSizes.iconSizeSmall, color: fg),
          const SizedBox(width: AppSpacing.space8),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.uiButtonLarge.copyWith(color: fg),
          ),
        ),
      ],
    );

    final button = Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Material(
        color: bg,
        shape: StadiumBorder(
          side: border == null ? BorderSide.none : BorderSide(color: border),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onPressed,
          child: Container(
            height: isText ? null : AppSizes.buttonHeight,
            alignment: Alignment.center,
            padding: isText
                ? const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space12,
                    vertical: AppSpacing.space8,
                  )
                : const EdgeInsets.symmetric(horizontal: AppSpacing.space24),
            child: content,
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
