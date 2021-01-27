// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsDto _$SettingsDtoFromJson(Map<String, dynamic> json) {
  return SettingsDto(
    json['localeCode'] as String,
    json['localeIdentifier'] as String,
    json['localeIcon'] as String,
    json['theme'] as String,
  )
    ..version = json['version'] as int
    ..active = json['active'] as String
    ..createdDate = json['createdDate'] as String
    ..createdBy = json['createdBy'] as String
    ..modifiedDate = json['modifiedDate'] as String
    ..modifiedBy = json['modifiedBy'] as String;
}

Map<String, dynamic> _$SettingsDtoToJson(SettingsDto instance) =>
    <String, dynamic>{
      'version': instance.version,
      'active': instance.active,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
      'localeCode': instance.localeCode,
      'localeIdentifier': instance.localeIdentifier,
      'localeIcon': instance.localeIcon,
      'theme': instance.theme,
    };
