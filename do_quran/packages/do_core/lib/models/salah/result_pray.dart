import 'package:do_core/models/salah/datetime_pray.dart';
import 'package:do_core/models/salah/location_pray.dart';
import 'package:do_core/models/salah/settings_pray.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_pray.g.dart';

@JsonSerializable()
class ResultPray {
  ResultPray(
    this.datetime,
    this.location,
    this.settings,
  );

  factory ResultPray.fromJson(Map<String, dynamic> json) =>
      _$ResultPrayFromJson(json);

  Map<String, dynamic> toJson() => _$ResultPrayToJson(this);

  List<DatetimePray> datetime;
  LocationPray location;
  SettingsPray settings;

  @override
  String toString() {
    return '''
ResultPray : {${'datetime: $datetime, '}${'location: $location, '}${'settings: $settings '}}''';
  }
}
