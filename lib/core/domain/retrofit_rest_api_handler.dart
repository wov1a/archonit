import 'dart:developer';

import 'package:crypto_test/core/data/models_srv/server_exception_response.dart';
import 'package:crypto_test/core/data/models_srv/validation_error_response.dart';
import 'package:crypto_test/core/data/rest_api_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract mixin class RetrofitRestApiHandler {
  @protected
  Future<RestApiResult<T>> handleExceptions<T>(
    final Object error,
    final StackTrace stackTrace,
  ) async {
    switch (error) {
      case DioException(:final response, :final error, :final type):
        if (error is DenyReason) {
          return DeniedRestApiResult(statusCode: null, reason: error);
        }

        if (response == null &&
            type == DioExceptionType.unknown &&
            error.toString().contains('Unsupported response type: Null')) {
          return VoidRestApiResult();
        }

        if (response == null) return const UnknownRestApiResult();
        final Response(:statusCode, :data) = response;
        if (statusCode == null) {
          return UnknownRestApiResult(
            headers: response.headers.map,
            json: response.data,
          );
        }

        return switch (statusCode) {
          400 => ValidationRestApiResult(
            statusCode: statusCode,
            description: ValidationErrorResponse.fromJson(data),
          ),
          401 => DeniedRestApiResult(
            statusCode: statusCode,
            reason: DenyReason.unAuth,
          ),
          403 => DeniedRestApiResult(
            statusCode: statusCode,
            reason: DenyReason.accessDenied,
          ),
          >= 500 => DeadRestApiResult(
            statusCode: statusCode,
            description: ServerExceptionResponse.fromJson(data),
          ),
          _ => UnknownRestApiResult(
            statusCode: statusCode,
            headers: response.headers.map,
            json: response.data,
          ),
        };
      default:
        log('RetrofitRestApiHandler', error: error, stackTrace: stackTrace);
        return const UnknownRestApiResult();
    }
  }

  @protected
  Future<RestApiResult<T>> request<T>(
    final Future<T> Function() callback,
  ) async {
    try {
      return RestApiResult.data(data: await callback());
    } catch (e, st) {
      return handleExceptions(e, st);
    }
  }
}
