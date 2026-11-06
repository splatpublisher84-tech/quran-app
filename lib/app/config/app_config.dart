import 'app_flavor.dart';

/// Immutable per-flavor configuration. Created once in the entry point and
/// injected through `ProviderScope` overrides (see `bootstrap.dart`).
class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.bundleSuffix,
  });

  final AppFlavor flavor;
  final String appName;

  /// Suffix appended to the base package/bundle id ('' for prod, '.dev' for dev).
  final String bundleSuffix;

  bool get isDev => flavor == AppFlavor.dev;
  bool get isProd => flavor == AppFlavor.prod;

  static AppConfig forFlavor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return const AppConfig(
          flavor: AppFlavor.dev,
          appName: 'Quran Dev',
          bundleSuffix: '.dev',
        );
      case AppFlavor.prod:
        return const AppConfig(
          flavor: AppFlavor.prod,
          appName: 'Quran',
          bundleSuffix: '',
        );
    }
  }
}
