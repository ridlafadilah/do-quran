import 'package:json_annotation/json_annotation.dart';

part 'ayah_entity.g.dart';

@JsonSerializable()
class AyahEntity {
  AyahEntity(
    this.id,
    this.numberOfAyah,
    this.text,
    this.idSurah,
  );

  factory AyahEntity.fromJson(Map<String, dynamic> json) =>
      _$AyahEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AyahEntityToJson(this);

  int id;
  @JsonKey(name: 'number_of_ayah')
  String numberOfAyah;
  String text;
  @JsonKey(name: 'id_surah')
  String idSurah;

  @override
  String toString() {
    return 'AyahEntity : {${'id: $id, '}${'numberOfAyah: $numberOfAyah, '}${'text: $text, '}${'idSurah: $idSurah '}}';
  }
}
