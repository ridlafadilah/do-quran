// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verses_bookmarks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersesBookmarks _$VersesBookmarksFromJson(Map<String, dynamic> json) {
  return VersesBookmarks(
    surah: json['surah'] as int,
    surahName: json['surah_name'] as String,
    ayah: json['ayah'] as int,
    ayahText: json['ayah_text'] as String,
    ayahTranslation: json['ayah_translation'] as String,
    notes: json['notes'] as String,
  );
}

Map<String, dynamic> _$VersesBookmarksToJson(VersesBookmarks instance) =>
    <String, dynamic>{
      'surah': instance.surah,
      'surah_name': instance.surahName,
      'ayah': instance.ayah,
      'ayah_text': instance.ayahText,
      'ayah_translation': instance.ayahTranslation,
      'notes': instance.notes,
    };
