import 'package:do_core/models/salah/date_pray.dart';
import 'package:do_core/models/salah/times_pray.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datetime_pray.g.dart';

@JsonSerializable()
class DatetimePray {
  DatetimePray(
    this.times,
    this.date,
  );

  factory DatetimePray.fromJson(Map<String, dynamic> json) =>
      _$DatetimePrayFromJson(json);

  Map<String, dynamic> toJson() => _$DatetimePrayToJson(this);

  TimesPray times;
  DatePray date;

  @override
  String toString() {
    return '''
DatetimePray : {${'times: $times, '}${'date: $date '}}''';
  }
}
