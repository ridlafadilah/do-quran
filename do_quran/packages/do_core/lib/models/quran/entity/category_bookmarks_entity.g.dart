// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_bookmarks_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBookmarksEntity _$CategoryBookmarksEntityFromJson(
    Map<String, dynamic> json) {
  return CategoryBookmarksEntity(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    type: json['type'] as String,
    version: json['version'] as String,
  );
}

Map<String, dynamic> _$CategoryBookmarksEntityToJson(
        CategoryBookmarksEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'version': instance.version,
    };
