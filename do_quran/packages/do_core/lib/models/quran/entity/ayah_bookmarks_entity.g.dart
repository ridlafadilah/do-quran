// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_bookmarks_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahBookmarksEntity _$AyahBookmarksEntityFromJson(Map<String, dynamic> json) {
  return AyahBookmarksEntity(
    id: json['id'] as int,
    numberOfSurah: json['number_of_surah'] as int,
    numberOfAyah: json['number_of_ayah'] as int,
    description: json['description'] as String,
    idCategory: json['id_category'] as int,
  );
}

Map<String, dynamic> _$AyahBookmarksEntityToJson(
        AyahBookmarksEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number_of_surah': instance.numberOfSurah,
      'number_of_ayah': instance.numberOfAyah,
      'description': instance.description,
      'id_category': instance.idCategory,
    };
