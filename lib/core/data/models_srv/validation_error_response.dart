import 'package:crypto_test/core/data/models_srv/validation_error_entry.dart';

import 'package:json_annotation/json_annotation.dart';

part 'validation_error_response.g.dart';

@JsonSerializable()
class ValidationErrorResponse {
  final String title;
  final int status;
  final String detail;
  final Map<String, List<ValidationErrorEntry>> errors;

  ValidationErrorResponse({
    required this.title,
    required this.status,
    required this.detail,
    required this.errors,
  });

  factory ValidationErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationErrorResponseToJson(this);
}
