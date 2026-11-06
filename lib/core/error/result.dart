import 'failure.dart';

/// Minimal success or failure container. Use cases return this instead of
/// throwing for expected failures.
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;

  T? get valueOrNull => switch (this) {
    Ok(:final value) => value,
    Err() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Ok() => null,
    Err(:final failure) => failure,
  };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}

/// Runs [body] and converts thrown errors into a [Result].
Future<Result<T>> guardResult<T>(Future<T> Function() body) async {
  try {
    return Ok(await body());
  } on AppException catch (e) {
    return Err(e.failure);
  } on Object catch (e) {
    return Err(UnknownFailure(e.toString()));
  }
}
