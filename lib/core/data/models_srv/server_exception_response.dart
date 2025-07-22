import 'package:json_annotation/json_annotation.dart';

part 'server_exception_response.g.dart';

@JsonSerializable()
class ServerExceptionResponse {
  final String type;
  final String message;
  final String stackTrace;
  final Map<String, String> data;

  ServerExceptionResponse({
    required this.type,
    required this.message,
    required this.stackTrace,
    required this.data,
  });

  factory ServerExceptionResponse.fromJson(Map<String, dynamic> json) =>
      _$ServerExceptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServerExceptionResponseToJson(this);
}
