import 'package:do_quran/model/quran/tafsir.dart';
import 'package:do_quran/model/quran/translations.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surah.g.dart';

@JsonSerializable()
class Surah {
  Surah(this.number, this.name, this.nameLatin, this.numberOfAyah, this.text,
      this.translations, this.tafsir);

  factory Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);

  Map<String, dynamic> toJson() => _$SurahToJson(this);

  String number;
  String name;
  @JsonKey(name: 'name_latin')
  String nameLatin;
  @JsonKey(name: 'number_of_ayah')
  String numberOfAyah;
  Map<String, String> text;
  Translations translations;
  Tafsir tafsir;

  @override
  String toString() {
    return '''
Surah : {${'number: $number, '}${'name: $name, '}${'nameLatin: $nameLatin, '}${'numberOfAyah: $numberOfAyah, '}${'text: $text, '}${'translations: $translations, '}${'tafsir: $tafsir, '}'}''';
  }
}
