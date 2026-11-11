import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/presentation/onboarding_controller.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/quran/presentation/quran_screen.dart';
import '../../features/quran/presentation/reader_screen.dart';
import '../../features/shell/presentation/app_shell_scaffold.dart';
import '../../features/shell/presentation/placeholder_screen.dart';
import '../../i18n/strings.g.dart';
import 'app_routes.dart';

/// Router with four tab branches. Users without the onboarding flag are sent
/// to onboarding, and completed users are kept out of it.
final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen<bool>(onboardingControllerProvider, (previous, next) {
    refresh.value++;
  });

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: refresh,
    redirect: (context, state) {
      final done = ref.read(onboardingControllerProvider);
      final onOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!done && !onOnboarding) return AppRoutes.onboarding;
      if (done && onOnboarding) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShellScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.quran,
                builder: (context, state) => const QuranScreen(),
                routes: [
                  GoRoute(
                    path: 'saved',
                    builder: (context, state) => const SavedAyahsScreen(),
                  ),
                  GoRoute(
                    path: 'surah/:surah',
                    builder: (context, state) {
                      final surah = int.tryParse(
                        state.pathParameters['surah'] ?? '',
                      );
                      final ayah = int.tryParse(
                        state.uri.queryParameters['ayah'] ?? '',
                      );
                      if (surah == null) {
                        return const ReaderScreen.surah(0);
                      }
                      return ReaderScreen.surah(surah, ayah: ayah);
                    },
                  ),
                  GoRoute(
                    path: 'juz/:juz',
                    builder: (context, state) {
                      final juz = int.tryParse(
                        state.pathParameters['juz'] ?? '',
                      );
                      if (juz == null) return const ReaderScreen.juz(0);
                      return ReaderScreen.juz(juz);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ayahOfDay,
                builder: (context, state) =>
                    PlaceholderScreen(title: context.t.tabs.ayahOfDay),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) =>
                    PlaceholderScreen(title: context.t.tabs.settings),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});
