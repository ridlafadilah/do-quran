// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_pray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatePray _$DatePrayFromJson(Map<String, dynamic> json) {
  return DatePray(
    json['timestamp'] as int,
    json['gregorian'] as String,
    json['hijri'] as String,
  );
}

Map<String, dynamic> _$DatePrayToJson(DatePray instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'gregorian': instance.gregorian,
      'hijri': instance.hijri,
    };
