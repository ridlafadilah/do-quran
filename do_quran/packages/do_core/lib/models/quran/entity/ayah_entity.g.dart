// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahEntity _$AyahEntityFromJson(Map<String, dynamic> json) {
  return AyahEntity(
    json['id'] as int,
    json['number_of_ayah'] as String,
    json['text'] as String,
    json['id_surah'] as String,
  );
}

Map<String, dynamic> _$AyahEntityToJson(AyahEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number_of_ayah': instance.numberOfAyah,
      'text': instance.text,
      'id_surah': instance.idSurah,
    };
