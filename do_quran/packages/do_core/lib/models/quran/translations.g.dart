// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translations _$TranslationsFromJson(Map<String, dynamic> json) {
  return Translations(
    id: json['id'] == null
        ? null
        : TranslationsId.fromJson(json['id'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TranslationsToJson(Translations instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
