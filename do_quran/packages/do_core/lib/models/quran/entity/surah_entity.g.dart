// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahEntity _$SurahEntityFromJson(Map<String, dynamic> json) {
  return SurahEntity(
    json['number'] as String,
    json['name'] as String,
    json['name_latin'] as String,
    json['total_ayah'] as String,
    (json['ayah'] as List)
        ?.map((e) =>
            e == null ? null : AyahEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['translations'] as List)
        ?.map((e) => e == null
            ? null
            : AyahTranslationEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurahEntityToJson(SurahEntity instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'name_latin': instance.nameLatin,
      'total_ayah': instance.totalAyah,
      'ayah': instance.ayah,
      'translations': instance.translations,
    };
