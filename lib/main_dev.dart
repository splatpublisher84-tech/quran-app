import 'app/config/app_config.dart';
import 'app/config/app_flavor.dart';
import 'bootstrap.dart';

/// Entry point for the dev flavor.
/// Run with: flutter run --flavor dev -t lib/main_dev.dart
Future<void> main() => bootstrap(AppConfig.forFlavor(AppFlavor.dev));
