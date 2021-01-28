import 'package:json_annotation/json_annotation.dart';

part 'times_pray.g.dart';

class TimesPrayBase {
  static String fajr = 'Fajr';
  static String dhuhr = 'Dhuhr';
  static String asr = 'Asr';
  static String maghrib = 'Maghrib';
  static String isha = 'Isha';
}

@JsonSerializable()
class TimesPray {
  TimesPray(
    this.imsak,
    this.sunrise,
    this.fajr,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.midnight,
  );

  factory TimesPray.fromJson(Map<String, dynamic> json) =>
      _$TimesPrayFromJson(json);

  Map<String, dynamic> toJson() => _$TimesPrayToJson(this);

  @JsonKey(name: 'Imsak')
  String imsak;
  @JsonKey(name: 'Sunrise')
  String sunrise;
  @JsonKey(name: 'Fajr')
  String fajr;
  @JsonKey(name: 'Dhuhr')
  String dhuhr;
  @JsonKey(name: 'Asr')
  String asr;
  @JsonKey(name: 'Sunset')
  String sunset;
  @JsonKey(name: 'Maghrib')
  String maghrib;
  @JsonKey(name: 'Isha')
  String isha;
  @JsonKey(name: 'Midnight')
  String midnight;

  @override
  String toString() {
    return '''
TimesPray : {${'imsak: $imsak, '}${'sunrise: $sunrise, '}${'fajr: $fajr, '}${'dhuhr: $dhuhr, '}${'asr: $asr, '}${'sunset: $sunset, '}${'maghrib: $maghrib, '}${'isha: $isha, '}${'midnight: $midnight '}}''';
  }
}
