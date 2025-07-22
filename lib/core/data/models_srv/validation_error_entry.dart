import 'package:json_annotation/json_annotation.dart';

part 'validation_error_entry.g.dart';

@JsonSerializable()
class ValidationErrorEntry {
  final String errorCode;
  final List<String>? params;

  ValidationErrorEntry({
    required this.errorCode,
    required this.params,
  });

  factory ValidationErrorEntry.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationErrorEntryToJson(this);
}
