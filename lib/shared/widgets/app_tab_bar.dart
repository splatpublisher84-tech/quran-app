import 'package:flutter/material.dart';

import '../../core/design_system/design_system.dart';

class AppTabItem {
  const AppTabItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Bottom tab bar. Shows one item per tab with icon and label.
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<AppTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SafeArea(
      top: false,
      child: Container(
        height: AppSizes.tabBarHeight,
        decoration: BoxDecoration(
          color: c.backgroundDefault,
          border: Border(
            top: BorderSide(color: c.borderDefault, width: AppSizes.hairline),
          ),
        ),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: _TabItem(
                  item: items[i],
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final AppTabItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = selected ? c.textPrimary : c.textSecondary;
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: AppSizes.iconSize, color: color),
            const SizedBox(height: AppSpacing.space4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.uiCaptionEmphasized.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
