import 'package:do_core/models/quran/kemenag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tafsir_id.g.dart';

@JsonSerializable()
class TafsirId {
  TafsirId(this.kemenag);

  factory TafsirId.fromJson(Map<String, dynamic> json) =>
      _$TafsirIdFromJson(json);

  Map<String, dynamic> toJson() => _$TafsirIdToJson(this);

  Kemenag kemenag;

  @override
  String toString() {
    return 'TafsirId : {${'kemenag: $kemenag '}}';
  }
}
