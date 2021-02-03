import 'package:json_annotation/json_annotation.dart';

part 'translations_id.g.dart';

@JsonSerializable()
class TranslationsId {
  TranslationsId({
    this.name,
    this.text,
  });

  factory TranslationsId.fromJson(Map<String, dynamic> json) =>
      _$TranslationsIdFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationsIdToJson(this);

  String name;
  Map<String, String> text;

  @override
  String toString() {
    return 'TranslationsId : {${'name: $name, '}${'text: $text '}}';
  }
}
