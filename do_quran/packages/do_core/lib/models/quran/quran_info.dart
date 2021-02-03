import 'package:json_annotation/json_annotation.dart';

part 'quran_info.g.dart';

@JsonSerializable()
class QuranInfo {
  QuranInfo(
      {this.translationIndonesia,
      this.translationEnglish,
      this.arabic,
      this.latin,
      this.ayahCount,
      this.index,
      this.opening,
      this.closing});

  factory QuranInfo.fromJson(Map<String, dynamic> json) =>
      _$QuranInfoFromJson(json);

  Map<String, dynamic> toJson() => _$QuranInfoToJson(this);

  @JsonKey(name: 'translation_id')
  String translationIndonesia;
  @JsonKey(name: 'translation_en')
  String translationEnglish;
  String arabic;
  String latin;
  @JsonKey(name: 'ayah_count')
  int ayahCount;
  int index;
  String opening;
  String closing;

  @override
  String toString() {
    return '''
QuranInfo : {${'translationIndonesia: $translationIndonesia, '}${'translationEnglish: $translationEnglish, '}${'arabic: $arabic, '}${'latin: $latin, '}${'ayahCount: $ayahCount, '}${'index: $index, '}${'opening: $opening, '}${'closing: $closing, '}'}''';
  }
}
