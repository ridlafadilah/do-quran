// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahEntity _$SurahEntityFromJson(Map<String, dynamic> json) {
  return SurahEntity(
    number: json['number'] as String,
    name: json['name'] as String,
    nameLatin: json['name_latin'] as String,
    totalAyah: json['total_ayah'] as String,
  );
}

Map<String, dynamic> _$SurahEntityToJson(SurahEntity instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'name_latin': instance.nameLatin,
      'total_ayah': instance.totalAyah,
    };
