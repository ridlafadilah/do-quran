import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ayah_translation_entity.g.dart';

@JsonSerializable()
class AyahTranslationEntity extends BaseEntity {
  AyahTranslationEntity({
    this.id,
    this.nameLatinSurah,
    this.numberOfAyah,
    this.text,
    this.l10n,
    this.idSurah,
  });

  factory AyahTranslationEntity.fromJson(Map<String, dynamic> json) =>
      _$AyahTranslationEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AyahTranslationEntityToJson(this);

  int id;
  @JsonKey(name: 'name_latin_surah')
  String nameLatinSurah;
  @JsonKey(name: 'number_of_ayah')
  String numberOfAyah;
  String text;
  String l10n = 'id';
  @JsonKey(name: 'id_surah')
  String idSurah;

  @override
  String toString() {
    return '''
AyahTranslationEntity : {${'id: $id, '}${'nameLatinSurah: $nameLatinSurah, '}${'numberOfAyah: $numberOfAyah, '}${'text: $text, '}${'l10n: $l10n, '}${'idSurah: $idSurah '}}''';
  }
}
