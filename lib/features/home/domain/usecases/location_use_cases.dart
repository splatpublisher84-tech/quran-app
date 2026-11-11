import '../../../../core/error/result.dart';
import '../location.dart';
import '../repositories/location_repository.dart';

class ResolveUserLocation {
  const ResolveUserLocation(this._repository);

  final LocationRepository _repository;

  Future<Result<LocationSnapshot>> call() => _repository.resolve();
}

class RequestLocationPermission {
  const RequestLocationPermission(this._repository);

  final LocationRepository _repository;

  Future<Result<LocationSnapshot>> call() => _repository.requestPermission();
}
