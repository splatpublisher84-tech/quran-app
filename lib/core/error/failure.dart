/// Typed failures returned by the data and platform layers. UI maps these to
/// localized copy, they never show raw exception text.
sealed class Failure {
  const Failure(this.message);

  /// Developer facing description. Not shown to users.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network unavailable']);
}

final class StorageFailure extends Failure {
  const StorageFailure([super.message = 'Local storage failed']);
}

final class PlatformFailure extends Failure {
  const PlatformFailure([super.message = 'Platform service failed']);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unexpected error']);
}

/// Exception wrapper used to throw a [Failure] across async boundaries.
class AppException implements Exception {
  const AppException(this.failure);

  final Failure failure;

  @override
  String toString() => 'AppException(${failure.message})';
}
