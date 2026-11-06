import 'package:dio/dio.dart';

/// Builds the shared HTTP client. The app is offline first, so network calls
/// are only for optional remote data and must never block a screen.
Dio createDio() {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );
}
