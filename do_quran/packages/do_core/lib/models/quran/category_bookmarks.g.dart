// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_bookmarks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBookmarks _$CategoryBookmarksFromJson(Map<String, dynamic> json) {
  return CategoryBookmarks(
    title: json['title'] as String,
    description: json['description'] as String,
    type: json['type'] as String,
    version: json['version'] as String,
    verses: (json['verses'] as List)
        ?.map((e) => e == null
            ? null
            : VersesBookmarks.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryBookmarksToJson(CategoryBookmarks instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'version': instance.version,
      'verses': instance.verses,
    };
