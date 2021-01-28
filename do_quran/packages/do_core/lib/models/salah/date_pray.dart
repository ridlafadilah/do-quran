import 'package:json_annotation/json_annotation.dart';

part 'date_pray.g.dart';

@JsonSerializable()
class DatePray {
  DatePray(
    this.timestamp,
    this.gregorian,
    this.hijri,
  );

  factory DatePray.fromJson(Map<String, dynamic> json) =>
      _$DatePrayFromJson(json);

  Map<String, dynamic> toJson() => _$DatePrayToJson(this);

  int timestamp;
  String gregorian;
  String hijri;

  @override
  String toString() {
    return '''
DatePray : {${'timestamp: $timestamp, '}${'gregorian: $gregorian, '}${'hijri: $hijri '}}''';
  }
}
