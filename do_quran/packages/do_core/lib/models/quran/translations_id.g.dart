// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translations_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationsId _$TranslationsIdFromJson(Map<String, dynamic> json) {
  return TranslationsId(
    json['name'] as String,
    (json['text'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$TranslationsIdToJson(TranslationsId instance) =>
    <String, dynamic>{
      'name': instance.name,
      'text': instance.text,
    };
