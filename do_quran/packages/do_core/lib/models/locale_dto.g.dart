// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleDto _$LocaleDtoFromJson(Map<String, dynamic> json) {
  return LocaleDto(
    json['localeCode'] as String,
    json['identifier'] as String,
    json['subIdentifier'] as String,
    json['icon'] as String,
    json['localeUsed'] as bool,
    json['localeDefault'] as bool,
    json['localeEnabled'] as bool,
  )
    ..version = json['version'] as int
    ..active = json['active'] as String
    ..createdDate = json['createdDate'] as String
    ..createdBy = json['createdBy'] as String
    ..modifiedDate = json['modifiedDate'] as String
    ..modifiedBy = json['modifiedBy'] as String;
}

Map<String, dynamic> _$LocaleDtoToJson(LocaleDto instance) => <String, dynamic>{
      'version': instance.version,
      'active': instance.active,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'localeCode': instance.localeCode,
      'identifier': instance.identifier,
      'subIdentifier': instance.subIdentifier,
      'icon': instance.icon,
      'localeUsed': instance.localeUsed,
      'localeDefault': instance.localeDefault,
      'localeEnabled': instance.localeEnabled,
    };
