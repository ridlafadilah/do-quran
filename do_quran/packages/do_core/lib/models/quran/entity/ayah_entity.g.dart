// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahEntity _$AyahEntityFromJson(Map<String, dynamic> json) {
  return AyahEntity(
    id: json['id'] as int,
    numberOfAyah: json['number_of_ayah'] as String,
    text: json['text'] as String,
    idSurah: json['id_surah'] as String,
  );
}

Map<String, dynamic> _$AyahEntityToJson(AyahEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number_of_ayah': instance.numberOfAyah,
      'text': instance.text,
      'id_surah': instance.idSurah,
    };
