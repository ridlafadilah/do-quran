// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_bookmarks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahBookmarks _$AyahBookmarksFromJson(Map<String, dynamic> json) {
  return AyahBookmarks(
    surah: json['surah'] as int,
    ayah: json['ayah'] as int,
    notes: json['notes'] as String,
  );
}

Map<String, dynamic> _$AyahBookmarksToJson(AyahBookmarks instance) =>
    <String, dynamic>{
      'surah': instance.surah,
      'ayah': instance.ayah,
      'notes': instance.notes,
    };
