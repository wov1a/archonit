import 'package:crypto_test/core/data/models_srv/server_exception_response.dart';
import 'package:crypto_test/core/data/models_srv/validation_error_response.dart';

enum DenyReason {
  unAuth('unAuth'),
  accessDenied('access-denied'),
  noInternet('no-internet');

  const DenyReason(this.code);

  final String code;
}

sealed class RestApiResult<T> {
  final int? statusCode;

  const RestApiResult({required this.statusCode});

  const factory RestApiResult.data({
    final int? statusCode,
    required final T data,
  }) = DataRestApiResult;

  const factory RestApiResult.error({
    final int? statusCode,
    required final ValidationErrorResponse description,
  }) = ValidationRestApiResult;

  bool get isSuccess => switch (statusCode) {
    null => false,
    >= 200 && < 300 => true,
    _ => false,
  };
}

class DataRestApiResult<T> extends RestApiResult<T> {
  final T data;

  const DataRestApiResult({super.statusCode, required this.data});
}

class VoidRestApiResult<T> extends RestApiResult<T> {
  const VoidRestApiResult({super.statusCode});
}

class ValidationRestApiResult<T> extends RestApiResult<T> {
  final ValidationErrorResponse description;

  const ValidationRestApiResult({super.statusCode, required this.description});
}

class DeadRestApiResult<T> extends RestApiResult<T> {
  final ServerExceptionResponse description;

  const DeadRestApiResult({
    required super.statusCode,
    required this.description,
  });
}

class DeniedRestApiResult<T> extends RestApiResult<T> {
  final DenyReason reason;

  const DeniedRestApiResult({required super.statusCode, required this.reason});
}

class UnknownRestApiResult<T> extends RestApiResult<T> {
  final Map<String, List<String>>? headers;
  final Map<String, dynamic>? json;
  final T? data;

  const UnknownRestApiResult({
    super.statusCode,
    this.headers,
    this.json,
    this.data,
  });
}
