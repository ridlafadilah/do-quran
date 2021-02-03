import 'package:do_core/models/quran/translations_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translations.g.dart';

@JsonSerializable()
class Translations {
  Translations({this.id});

  factory Translations.fromJson(Map<String, dynamic> json) =>
      _$TranslationsFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationsToJson(this);

  TranslationsId id;

  @override
  String toString() {
    return 'Translations : {${'id: $id, '}}';
  }
}
