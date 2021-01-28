// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datetime_pray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatetimePray _$DatetimePrayFromJson(Map<String, dynamic> json) {
  return DatetimePray(
    json['times'] == null
        ? null
        : TimesPray.fromJson(json['times'] as Map<String, dynamic>),
    json['date'] == null
        ? null
        : DatePray.fromJson(json['date'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DatetimePrayToJson(DatetimePray instance) =>
    <String, dynamic>{
      'times': instance.times,
      'date': instance.date,
    };
