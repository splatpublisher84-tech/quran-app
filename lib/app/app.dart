import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/design_system/design_system.dart';
import '../i18n/strings.g.dart';
import '../core/di/infrastructure_providers.dart';
import 'router/app_router.dart';

/// Root widget. Light theme is the default.
class QuranApp extends ConsumerWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final router = ref.watch(appRouterProvider);
    return ScreenUtilInit(
      // Design canvas from dev-handoff (393x852 pt, same as Bible).
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, _) => TranslationProvider(
        child: Builder(
          builder: (context) => MaterialApp.router(
            title: config.appName,
            debugShowCheckedModeBanner: config.isDev,
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.light,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
