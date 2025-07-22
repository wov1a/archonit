// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'crypto_data_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CryptoDataModel {
  final int offset;
  final int limit;

  const CryptoDataModel({this.offset = 0, this.limit = 15});

  factory CryptoDataModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoDataModelToJson(this);

  CryptoDataModel copyWith({int? offset, int? limit}) {
    return CryptoDataModel(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
