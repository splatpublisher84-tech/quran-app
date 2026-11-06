import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';

/// Scaffold around the four tab branches. Re-tapping the active tab resets
/// that branch to its root.
class AppShellScaffold extends StatelessWidget {
  const AppShellScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppTabBar(
        items: [
          AppTabItem(icon: Icons.home_rounded, label: t.tabs.home),
          AppTabItem(icon: Icons.menu_book_rounded, label: t.tabs.quran),
          AppTabItem(icon: Icons.auto_awesome_rounded, label: t.tabs.ayahOfDay),
          AppTabItem(icon: Icons.settings_rounded, label: t.tabs.settings),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
