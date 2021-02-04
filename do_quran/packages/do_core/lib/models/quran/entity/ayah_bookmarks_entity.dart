import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ayah_bookmarks_entity.g.dart';

@JsonSerializable()
class AyahBookmarksEntity extends BaseEntity {
  AyahBookmarksEntity({
    this.id,
    this.numberOfSurah,
    this.numberOfAyah,
    this.description,
    this.idCategory,
  });

  factory AyahBookmarksEntity.fromJson(Map<String, dynamic> json) =>
      _$AyahBookmarksEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AyahBookmarksEntityToJson(this);

  int id;
  @JsonKey(name: 'number_of_surah')
  int numberOfSurah;
  @JsonKey(name: 'number_of_ayah')
  int numberOfAyah;
  String description;
  @JsonKey(name: 'id_category')
  int idCategory;

  @override
  String toString() {
    return '''
AyahBookmarksEntity : {${'id: $id, '}${'numberOfSurah: $numberOfSurah, '}${'numberOfAyah: $numberOfAyah, '}${'description: $description '}}''';
  }
}
