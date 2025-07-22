import 'package:json_annotation/json_annotation.dart';

part 'crypto_item_model.g.dart';

@JsonSerializable()
class CryptoItemModel {
  final String name;
  final String priceUsd;

  CryptoItemModel({required this.name, required this.priceUsd});

  factory CryptoItemModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoItemModelToJson(this);
}
