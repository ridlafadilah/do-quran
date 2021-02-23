import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ayah_bookmarks.g.dart';

@JsonSerializable()
class AyahBookmarks extends BaseEntity {
  AyahBookmarks({
    this.surah,
    this.ayah,
    this.notes,
  });

  factory AyahBookmarks.fromJson(Map<String, dynamic> json) =>
      _$AyahBookmarksFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AyahBookmarksToJson(this);

  int surah;
  int ayah;
  String notes;

  @override
  String toString() {
    return '''
AyahBookmarks : {${'surah: $surah, '}${'ayah: $ayah, '}${'notes: $notes '}}''';
  }
}
