import 'app/config/app_config.dart';
import 'app/config/app_flavor.dart';
import 'bootstrap.dart';

/// Entry point for the prod flavor.
/// Run with: flutter run --flavor prod -t lib/main_prod.dart
Future<void> main() => bootstrap(AppConfig.forFlavor(AppFlavor.prod));
