import 'package:do_core/models/quran/entity/ayah_bookmarks_entity.dart';
import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_bookmarks.g.dart';

@JsonSerializable()
class CategoryBookmarks extends BaseEntity {
  CategoryBookmarks({
    this.title,
    this.description,
    this.type,
    this.version,
  });

  factory CategoryBookmarks.fromJson(Map<String, dynamic> json) =>
      _$CategoryBookmarksFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryBookmarksToJson(this);

  String title;
  String description;
  String type;
  String version;
  List<AyahBookmarksEntity> ayah;

  @override
  String toString() {
    return '''
CategoryBookmarks : {${'title: $title, '}${'description: $description, '}${'type: $type, '}${'version: $version '}}''';
  }
}
