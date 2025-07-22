// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationErrorResponse _$ValidationErrorResponseFromJson(
  Map<String, dynamic> json,
) => ValidationErrorResponse(
  title: json['title'] as String,
  status: (json['status'] as num).toInt(),
  detail: json['detail'] as String,
  errors: (json['errors'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>)
          .map((e) => ValidationErrorEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  ),
);

Map<String, dynamic> _$ValidationErrorResponseToJson(
  ValidationErrorResponse instance,
) => <String, dynamic>{
  'title': instance.title,
  'status': instance.status,
  'detail': instance.detail,
  'errors': instance.errors,
};
