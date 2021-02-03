import 'package:do_core/models/quran/tafsir_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tafsir.g.dart';

@JsonSerializable()
class Tafsir {
  Tafsir({this.id});

  factory Tafsir.fromJson(Map<String, dynamic> json) => _$TafsirFromJson(json);

  Map<String, dynamic> toJson() => _$TafsirToJson(this);

  TafsirId id;

  @override
  String toString() {
    return 'Tafsir : {${'id: $id '}}';
  }
}
