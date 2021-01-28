import 'package:do_core/models/salah/result_pray.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pray.g.dart';

@JsonSerializable()
class Pray {
  Pray(
    this.code,
    this.status,
    this.results,
  );

  factory Pray.fromJson(Map<String, dynamic> json) => _$PrayFromJson(json);

  Map<String, dynamic> toJson() => _$PrayToJson(this);

  int code;
  String status;
  ResultPray results;

  @override
  String toString() {
    return 'Pray : {${'code: $code, '}${'status: $status, '}${'results: $results '}}';
  }
}
