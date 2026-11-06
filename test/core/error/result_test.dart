import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/error/failure.dart';
import 'package:quran_app/core/error/result.dart';

void main() {
  test('Ok exposes its value and no failure', () {
    const result = Ok(42);
    expect(result.isOk, isTrue);
    expect(result.valueOrNull, 42);
    expect(result.failureOrNull, isNull);
  });

  test('Err exposes its failure and no value', () {
    const result = Err<int>(NetworkFailure());
    expect(result.isOk, isFalse);
    expect(result.valueOrNull, isNull);
    expect(result.failureOrNull, isA<NetworkFailure>());
  });

  test('guardResult wraps a successful body', () async {
    final result = await guardResult(() async => 'ok');
    expect(result.valueOrNull, 'ok');
  });

  test('guardResult maps AppException to its failure', () async {
    final result = await guardResult<int>(() async {
      throw const AppException(StorageFailure('disk full'));
    });
    expect(result.failureOrNull, isA<StorageFailure>());
  });

  test('guardResult maps other errors to UnknownFailure', () async {
    final result = await guardResult<int>(() async {
      throw StateError('boom');
    });
    expect(result.failureOrNull, isA<UnknownFailure>());
  });
}
