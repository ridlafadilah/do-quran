import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quran_info_entity.g.dart';

@JsonSerializable()
class QuranInfoEntity extends BaseEntity {
  QuranInfoEntity(
      {this.translationIndonesia,
      this.translationEnglish,
      this.arabic,
      this.latin,
      this.ayahCount,
      this.index,
      this.opening,
      this.closing});

  factory QuranInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$QuranInfoEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuranInfoEntityToJson(this);

  @JsonKey(name: 'translation_id')
  String translationIndonesia;
  @JsonKey(name: 'translation_en')
  String translationEnglish;
  String arabic;
  String latin;
  @JsonKey(name: 'ayah_count')
  int ayahCount;
  @JsonKey(name: 'idx')
  int index;
  String opening;
  String closing;

  @override
  String toString() {
    return '''
QuranInfoEntity : {${'translationIndonesia: $translationIndonesia, '}${'translationEnglish: $translationEnglish, '}${'arabic: $arabic, '}${'latin: $latin, '}${'ayahCount: $ayahCount, '}${'index: $index, '}${'opening: $opening, '}${'closing: $closing, '}'}''';
  }
}
