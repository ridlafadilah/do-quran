// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pray _$PrayFromJson(Map<String, dynamic> json) {
  return Pray(
    json['code'] as int,
    json['status'] as String,
    json['results'] == null
        ? null
        : ResultPray.fromJson(json['results'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PrayToJson(Pray instance) => <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'results': instance.results,
    };
