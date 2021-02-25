// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verses_bookmarks_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersesBookmarksEntity _$VersesBookmarksEntityFromJson(
    Map<String, dynamic> json) {
  return VersesBookmarksEntity(
    id: json['id'] as int,
    surah: json['surah'] as int,
    surahName: json['surah_name'] as String,
    ayah: json['ayah'] as int,
    ayahText: json['ayah_text'] as String,
    ayahTranslation: json['ayah_translation'] as String,
    notes: json['notes'] as String,
  )..idCategory = json['id_category'] as int;
}

Map<String, dynamic> _$VersesBookmarksEntityToJson(
        VersesBookmarksEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surah': instance.surah,
      'surah_name': instance.surahName,
      'ayah': instance.ayah,
      'ayah_text': instance.ayahText,
      'ayah_translation': instance.ayahTranslation,
      'notes': instance.notes,
      'id_category': instance.idCategory,
    };
