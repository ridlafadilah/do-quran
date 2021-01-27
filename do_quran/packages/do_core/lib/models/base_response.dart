import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  BaseResponse(this.respStatusCode, this.respStatusMessage);

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  String respStatusCode;
  Map<String, dynamic> respStatusMessage;

  @override
  String toString() => '''
BaseResponse : {${'respStatusCode: $respStatusCode, '}${'respStatusMessage: $respStatusMessage}'}''';
}
