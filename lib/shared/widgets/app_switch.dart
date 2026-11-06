import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Switch colored with brand tokens.
class AppSwitch extends StatelessWidget {
  const AppSwitch({required this.value, this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: c.onBrand,
      activeTrackColor: c.brand,
      inactiveThumbColor: c.textSecondary,
      inactiveTrackColor: c.surfaceMuted,
      trackOutlineColor: WidgetStatePropertyAll(c.border),
    );
  }
}
