// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
    json['respStatusCode'] as String,
    json['respStatusMessage'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'respStatusCode': instance.respStatusCode,
      'respStatusMessage': instance.respStatusMessage,
    };
