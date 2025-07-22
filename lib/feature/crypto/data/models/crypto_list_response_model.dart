import 'package:crypto_test/feature/crypto/data/models/crypto_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_list_response_model.g.dart';

@JsonSerializable()
class CryptoListResponse {
  final int timestamp;
  final List<CryptoItemModel> data;

  CryptoListResponse({required this.timestamp, required this.data});

  factory CryptoListResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoListResponseToJson(this);
}
