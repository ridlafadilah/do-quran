import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verses_bookmarks_entity.g.dart';

@JsonSerializable()
class VersesBookmarksEntity extends BaseEntity {
  VersesBookmarksEntity({
    this.id,
    this.surah,
    this.surahName,
    this.ayah,
    this.ayahText,
    this.ayahTranslation,
    this.notes,
  });

  factory VersesBookmarksEntity.fromJson(Map<String, dynamic> json) =>
      _$VersesBookmarksEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VersesBookmarksEntityToJson(this);

  int id;
  int surah;
  @JsonKey(name: 'surah_name')
  String surahName;
  int ayah;
  @JsonKey(name: 'ayah_text')
  String ayahText;
  @JsonKey(name: 'ayah_translation')
  String ayahTranslation;
  String notes;
  @JsonKey(name: 'id_category')
  int idCategory;

  @override
  String toString() {
    return '''
VersesBookmarksEntity : {${'id: $id, '}${'surah: $surah, '}${'surahName: $surahName, '}${'ayah: $ayah, '}${'ayahText: $ayahText, '}${'ayahTranslation: $ayahTranslation, '}${'notes: $notes '}}''';
  }
}
