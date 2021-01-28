// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_pray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultPray _$ResultPrayFromJson(Map<String, dynamic> json) {
  return ResultPray(
    (json['datetime'] as List)
        ?.map((e) =>
            e == null ? null : DatetimePray.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['location'] == null
        ? null
        : LocationPray.fromJson(json['location'] as Map<String, dynamic>),
    json['settings'] == null
        ? null
        : SettingsPray.fromJson(json['settings'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultPrayToJson(ResultPray instance) =>
    <String, dynamic>{
      'datetime': instance.datetime,
      'location': instance.location,
      'settings': instance.settings,
    };
