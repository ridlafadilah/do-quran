// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_bookmarks_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahBookmarksEntity _$AyahBookmarksEntityFromJson(Map<String, dynamic> json) {
  return AyahBookmarksEntity(
    id: json['id'] as int,
    surah: json['surah'] as int,
    ayah: json['ayah'] as int,
    notes: json['notes'] as String,
    idCategory: json['id_category'] as int,
  );
}

Map<String, dynamic> _$AyahBookmarksEntityToJson(
        AyahBookmarksEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surah': instance.surah,
      'ayah': instance.ayah,
      'notes': instance.notes,
      'id_category': instance.idCategory,
    };
