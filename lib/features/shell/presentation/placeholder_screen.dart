import 'package:flutter/material.dart';

import '../../../core/design_system/design_system.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/shared_widgets.dart';

/// Stand in body for tabs that are built in later milestones.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(title: title),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space24),
          child: Text(
            context.t.common.comingSoon,
            textAlign: TextAlign.center,
            style: AppTextStyles.uiBodyRegular.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
