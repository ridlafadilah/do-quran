import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ayah_bookmarks_entity.g.dart';

@JsonSerializable()
class AyahBookmarksEntity extends BaseEntity {
  AyahBookmarksEntity({
    this.id,
    this.surah,
    this.ayah,
    this.notes,
    this.idCategory,
  });

  factory AyahBookmarksEntity.fromJson(Map<String, dynamic> json) =>
      _$AyahBookmarksEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AyahBookmarksEntityToJson(this);

  int id;
  int surah;
  int ayah;
  String notes;
  @JsonKey(name: 'id_category')
  int idCategory;

  @override
  String toString() {
    return '''
AyahBookmarksEntity : {${'id: $id, '}${'surah: $surah, '}${'ayah: $ayah, '}${'notes: $notes '}}''';
  }
}
