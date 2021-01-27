import 'package:do_core/models/base_audit_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locale_dto.g.dart';

@JsonSerializable()
class LocaleDto extends BaseAuditDto {
  LocaleDto(
    this.localeCode,
    this.identifier,
    this.subIdentifier,
    this.icon,
    this.localeUsed,
    this.localeDefault,
    this.localeEnabled,
  );

  factory LocaleDto.fromJson(Map<String, dynamic> json) =>
      _$LocaleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleDtoToJson(this);

  String localeCode;
  String identifier;
  String subIdentifier;
  String icon;
  bool localeUsed = false;
  bool localeDefault;
  bool localeEnabled;
}
