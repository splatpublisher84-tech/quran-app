import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/config/app_config.dart';
import '../network/dio_factory.dart';
import '../platform/clock.dart';

/// Providers for app wide infrastructure. The provider container is the only
/// DI mechanism. Values that exist only after async startup are supplied via
/// `ProviderScope.overrides` in `bootstrap.dart`.
final appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError('appConfigProvider must be overridden'),
);

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) =>
      throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final clockProvider = Provider<AppClock>((ref) => const SystemClock());

final dioProvider = Provider<Dio>((ref) {
  final dio = createDio();
  ref.onDispose(dio.close);
  return dio;
});
