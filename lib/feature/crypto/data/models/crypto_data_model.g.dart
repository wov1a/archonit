// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoDataModel _$CryptoDataModelFromJson(Map<String, dynamic> json) =>
    CryptoDataModel(
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 15,
    );

Map<String, dynamic> _$CryptoDataModelToJson(CryptoDataModel instance) =>
    <String, dynamic>{'offset': instance.offset, 'limit': instance.limit};
