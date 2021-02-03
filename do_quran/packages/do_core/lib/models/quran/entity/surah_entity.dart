import 'package:do_core/models/quran/entity/ayah_entity.dart';
import 'package:do_core/models/quran/entity/ayah_translation_entity.dart';
import 'package:do_core/models/quran/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surah_entity.g.dart';

@JsonSerializable()
class SurahEntity extends BaseEntity {
  SurahEntity(
      {this.number,
      this.name,
      this.nameLatin,
      this.totalAyah,
      this.ayah,
      this.translations});

  factory SurahEntity.fromJson(Map<String, dynamic> json) =>
      _$SurahEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SurahEntityToJson(this);

  String number;
  String name;
  @JsonKey(name: 'name_latin')
  String nameLatin;
  @JsonKey(name: 'total_ayah')
  String totalAyah;
  @JsonKey(ignore: true)
  List<AyahEntity> ayah;
  @JsonKey(ignore: true)
  List<AyahTranslationEntity> translations;

  @override
  String toString() {
    return '''
SurahEntity : {${'number: $number, '}${'name: $name, '}${'nameLatin: $nameLatin, '}${'totalAyah: $totalAyah, '}${'ayah: $ayah, '}${'translations: $translations '}'}''';
  }
}
