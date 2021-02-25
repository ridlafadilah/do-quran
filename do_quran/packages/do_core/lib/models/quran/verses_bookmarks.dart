import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verses_bookmarks.g.dart';

@JsonSerializable()
class VersesBookmarks extends BaseEntity {
  VersesBookmarks({
    this.surah,
    this.surahName,
    this.ayah,
    this.ayahText,
    this.ayahTranslation,
    this.notes,
  });

  factory VersesBookmarks.fromJson(Map<String, dynamic> json) =>
      _$VersesBookmarksFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VersesBookmarksToJson(this);

  int surah;
  @JsonKey(name: 'surah_name')
  String surahName;
  int ayah;
  @JsonKey(name: 'ayah_text')
  String ayahText;
  @JsonKey(name: 'ayah_translation')
  String ayahTranslation;
  String notes;

  @override
  String toString() {
    return '''
VersesBookmarks : {${'surah: $surah, '}${'surahName: $surahName, '}${'ayah: $ayah, '}${'ayahText: $ayahText, '}${'ayahTranslation: $ayahTranslation, '}${'notes: $notes '}}''';
  }
}
