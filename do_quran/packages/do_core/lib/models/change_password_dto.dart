import 'package:json_annotation/json_annotation.dart';

part 'change_password_dto.g.dart';

@JsonSerializable()
class ChangePasswordDto {
  ChangePasswordDto(
    this.password,
    this.newPassword,
    this.confirmPassword,
  );

  factory ChangePasswordDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordDtoToJson(this);

  String password;
  String newPassword;
  String confirmPassword;
}
