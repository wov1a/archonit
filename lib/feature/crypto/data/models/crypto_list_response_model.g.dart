// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoListResponse _$CryptoListResponseFromJson(Map<String, dynamic> json) =>
    CryptoListResponse(
      timestamp: (json['timestamp'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CryptoItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CryptoListResponseToJson(CryptoListResponse instance) =>
    <String, dynamic>{'timestamp': instance.timestamp, 'data': instance.data};
