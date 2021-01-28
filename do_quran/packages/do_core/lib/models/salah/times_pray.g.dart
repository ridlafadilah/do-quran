// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'times_pray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimesPray _$TimesPrayFromJson(Map<String, dynamic> json) {
  return TimesPray(
    json['Imsak'] as String,
    json['Sunrise'] as String,
    json['Fajr'] as String,
    json['Dhuhr'] as String,
    json['Asr'] as String,
    json['Sunset'] as String,
    json['Maghrib'] as String,
    json['Isha'] as String,
    json['Midnight'] as String,
  );
}

Map<String, dynamic> _$TimesPrayToJson(TimesPray instance) => <String, dynamic>{
      'Imsak': instance.imsak,
      'Sunrise': instance.sunrise,
      'Fajr': instance.fajr,
      'Dhuhr': instance.dhuhr,
      'Asr': instance.asr,
      'Sunset': instance.sunset,
      'Maghrib': instance.maghrib,
      'Isha': instance.isha,
      'Midnight': instance.midnight,
    };
