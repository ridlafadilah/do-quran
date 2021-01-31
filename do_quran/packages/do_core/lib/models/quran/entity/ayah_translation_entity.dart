import 'package:json_annotation/json_annotation.dart';

part 'ayah_translation_entity.g.dart';

@JsonSerializable()
class AyahTranslationEntity {
  AyahTranslationEntity(
    this.id,
    this.numberOfAyah,
    this.text,
    this.l10n,
    this.idSurah,
  );

  factory AyahTranslationEntity.fromJson(Map<String, dynamic> json) =>
      _$AyahTranslationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AyahTranslationEntityToJson(this);

  int id;
  @JsonKey(name: 'number_of_ayah')
  String numberOfAyah;
  String text;
  String l10n = 'id';
  @JsonKey(name: 'id_surah')
  String idSurah;

  @override
  String toString() {
    return 'AyahTranslationEntity : {${'id: $id, '}${'numberOfAyah: $numberOfAyah, '}${'text: $text, '}${'l10n: $l10n, '}${'idSurah: $idSurah '}}';
  }
}
