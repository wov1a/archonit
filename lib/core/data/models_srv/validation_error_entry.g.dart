// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationErrorEntry _$ValidationErrorEntryFromJson(
  Map<String, dynamic> json,
) => ValidationErrorEntry(
  errorCode: json['errorCode'] as String,
  params: (json['params'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ValidationErrorEntryToJson(
  ValidationErrorEntry instance,
) => <String, dynamic>{
  'errorCode': instance.errorCode,
  'params': instance.params,
};
