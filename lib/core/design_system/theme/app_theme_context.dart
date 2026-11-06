import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';

extension AppThemeContext on BuildContext {
  /// Semantic colors for the active theme.
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
