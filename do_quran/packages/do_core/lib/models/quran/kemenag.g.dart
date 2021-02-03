// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kemenag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kemenag _$KemenagFromJson(Map<String, dynamic> json) {
  return Kemenag(
    name: json['name'] as String,
    text: (json['text'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  )..source = json['source'] as String;
}

Map<String, dynamic> _$KemenagToJson(Kemenag instance) => <String, dynamic>{
      'name': instance.name,
      'source': instance.source,
      'text': instance.text,
    };
