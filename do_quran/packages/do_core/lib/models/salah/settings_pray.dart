import 'package:json_annotation/json_annotation.dart';

part 'settings_pray.g.dart';

@JsonSerializable()
class SettingsPray {
  SettingsPray(
    this.timeformat,
    this.school,
    this.juristic,
    this.highlat,
    this.fajrAngle,
    this.ishaAngle,
  );

  factory SettingsPray.fromJson(Map<String, dynamic> json) =>
      _$SettingsPrayFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsPrayToJson(this);

  String timeformat;
  String school;
  String juristic;
  String highlat;
  @JsonKey(name: 'fajr_angle')
  double fajrAngle;
  @JsonKey(name: 'isha_angle')
  double ishaAngle;

  @override
  String toString() {
    return '''
SettingsPray : {${'timeformat: $timeformat, '}${'school: $school, '}${'juristic: $juristic, '}${'highlat: $highlat, '}${'fajrAngle: $fajrAngle, '}${'ishaAngle: $ishaAngle '}}''';
  }
}
