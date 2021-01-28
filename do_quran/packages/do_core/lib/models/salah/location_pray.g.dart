// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_pray.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationPray _$LocationPrayFromJson(Map<String, dynamic> json) {
  return LocationPray(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    (json['elevation'] as num)?.toDouble(),
    json['city'] as String,
    json['country'] as String,
    json['country_code'] as String,
    json['timezone'] as String,
    (json['local_offset'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationPrayToJson(LocationPray instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'elevation': instance.elevation,
      'city': instance.city,
      'country': instance.country,
      'country_code': instance.countryCode,
      'timezone': instance.timezone,
      'local_offset': instance.localOffset,
    };
