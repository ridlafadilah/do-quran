import 'package:json_annotation/json_annotation.dart';

part 'location_pray.g.dart';

@JsonSerializable()
class LocationPray {
  LocationPray(
    this.latitude,
    this.longitude,
    this.elevation,
    this.city,
    this.country,
    this.countryCode,
    this.timezone,
    this.localOffset,
  );

  factory LocationPray.fromJson(Map<String, dynamic> json) =>
      _$LocationPrayFromJson(json);

  Map<String, dynamic> toJson() => _$LocationPrayToJson(this);

  double latitude;
  double longitude;
  double elevation;
  String city;
  String country;
  @JsonKey(name: 'country_code')
  String countryCode;
  String timezone;
  @JsonKey(name: 'local_offset')
  double localOffset;

  @override
  String toString() {
    return '''
LocationPray : {${'latitude: $latitude, '}${'longitude: $longitude, '}${'elevation: $elevation, '}${'city: $city, '}${'country: $country, '}${'countryCode: $countryCode, '}${'timezone: $timezone, '}${'localOffset: $localOffset '}}''';
  }
}
