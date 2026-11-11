import '../../../../core/error/result.dart';
import '../location.dart';

/// Resolves a coordinate and performs the permission actions Home asks for.
abstract interface class LocationRepository {
  Future<Result<LocationSnapshot>> resolve();

  /// Asks for while-in-use permission, then resolves again.
  Future<Result<LocationSnapshot>> requestPermission();

  Future<Result<bool>> openAppSettings();

  Future<Result<bool>> openLocationSettings();
}
