import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

/// Top navigation bar for pushed screens. Colors come from the theme's
/// `AppBarTheme`, which is built from `AppColors`.
class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({
    required this.title,
    this.leading,
    this.actions = const [],
    super.key,
  });

  final String title;
  final Widget? leading;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.navBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), leading: leading, actions: actions);
  }
}
