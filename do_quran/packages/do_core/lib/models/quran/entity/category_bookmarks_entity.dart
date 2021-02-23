import 'package:do_core/models/quran/entity/ayah_bookmarks_entity.dart';
import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_bookmarks_entity.g.dart';

class TypeBookmarks {
  static String pinnedAyah = 'PINNED_AYAH';
  static String lastAyah = 'LAST_AYAH';
}

@JsonSerializable()
class CategoryBookmarksEntity extends BaseEntity {
  CategoryBookmarksEntity({
    this.id,
    this.title,
    this.description,
    this.type,
    this.version,
  });

  factory CategoryBookmarksEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryBookmarksEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryBookmarksEntityToJson(this);

  int id;
  String title;
  String description;
  String type;
  String version;
  @JsonKey(ignore: true)
  List<AyahBookmarksEntity> ayah;

  @override
  String toString() {
    return '''
CategoryBookmarksEntity : {${'id: $id, '}${'title: $title, '}${'description: $description, '}${'type: $type, '}${'version: $version '}}''';
  }
}
