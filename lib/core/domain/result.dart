import 'package:crypto_test/core/data/rest_api_result.dart';
import 'package:crypto_test/core/domain/app_error/app_error.dart';

sealed class Result<T> {
  bool get isSuccess;

  const factory Result.data(T data) = DataResult;

  const factory Result.error({
    final Map<String, List<ValidationError>> errorMap,
    final SpecificError? specificError,
  }) = ErrorResult;

  factory Result.fromRestApi(
    RestApiResult<T> result, {
    Result<T> Function(DataRestApiResult<T> dataResult)? onData,
    Result<T> Function(ValidationRestApiResult<T> errorResult)?
    onValidationError,
    Result<T> Function(DeadRestApiResult<T> errorResult)? onSpecificError,
    Result<T> Function(DeniedRestApiResult<T> result)? onDeniedResult,
    Result<T> Function(UnknownRestApiResult<T> unknownResult)? onUnknown,
  }) {
    switch (result) {
      case DataRestApiResult<T>(:final data):
        return onData?.call(result) ?? Result.data(data);
      case ValidationRestApiResult<T>(:final description):
        return onValidationError?.call(result) ??
            Result.error(
              errorMap: AppError.fromValidationResponse(description),
            );
      case DeadRestApiResult<T>(:final description):
        return onSpecificError?.call(result) ??
            Result.error(
              specificError: AppError.fromServerException(description),
            );
      case DeniedRestApiResult<T>(:final reason):
        return Result.error(specificError: SpecificError(reason.code));
      case UnknownRestApiResult<T>():
        return onUnknown?.call(result) ??
            const Result.error(specificError: SpecificError('unknown'));
      case VoidRestApiResult<T>():
        return VoidResult<T>();
    }
  }
}

class DataResult<T> implements Result<T> {
  final T data;

  const DataResult(this.data);

  @override
  bool get isSuccess => true;
}

class VoidResult<T> implements DataResult<T> {
  @override
  bool get isSuccess => true;

  const VoidResult() : data = null as T;

  @override
  final T data;
}

class ErrorResult<T> implements Result<T> {
  final Map<String, List<ValidationError>> errorMap;
  final SpecificError? specificError;

  const ErrorResult({this.errorMap = const {}, this.specificError});

  @override
  bool get isSuccess => false;
}
