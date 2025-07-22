// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_exception_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerExceptionResponse _$ServerExceptionResponseFromJson(
  Map<String, dynamic> json,
) => ServerExceptionResponse(
  type: json['type'] as String,
  message: json['message'] as String,
  stackTrace: json['stackTrace'] as String,
  data: Map<String, String>.from(json['data'] as Map),
);

Map<String, dynamic> _$ServerExceptionResponseToJson(
  ServerExceptionResponse instance,
) => <String, dynamic>{
  'type': instance.type,
  'message': instance.message,
  'stackTrace': instance.stackTrace,
  'data': instance.data,
};
