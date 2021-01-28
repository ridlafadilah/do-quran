// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_pray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsPray _$SettingsPrayFromJson(Map<String, dynamic> json) {
  return SettingsPray(
    json['timeformat'] as String,
    json['school'] as String,
    json['juristic'] as String,
    json['highlat'] as String,
    (json['fajr_angle'] as num)?.toDouble(),
    (json['isha_angle'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SettingsPrayToJson(SettingsPray instance) =>
    <String, dynamic>{
      'timeformat': instance.timeformat,
      'school': instance.school,
      'juristic': instance.juristic,
      'highlat': instance.highlat,
      'fajr_angle': instance.fajrAngle,
      'isha_angle': instance.ishaAngle,
    };
