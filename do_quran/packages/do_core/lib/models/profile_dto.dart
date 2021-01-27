import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto {
  ProfileDto(
    this.username,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.country,
    this.countryCode,
    this.province,
    this.provinceCode,
    this.city,
    this.cityCode,
    this.district,
    this.districtCode,
    this.subDistrict,
    this.subDistrictCode,
    this.zipcode,
    this.image,
    this.description,
    this.idNumber,
    this.age,
    this.gender,
    this.genderCode,
    this.placeOfBirth,
    this.dateOfBirth,
    this.version,
    this.active,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  );

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

  String username;
  String name;
  String email;
  String phoneNumber;
  String address;
  String country;
  String countryCode;
  String province;
  String provinceCode;
  String city;
  String cityCode;
  String district;
  String districtCode;
  String subDistrict;
  String subDistrictCode;
  String zipcode;
  String image;
  String description;
  String idNumber;
  int age;
  String gender;
  String genderCode;
  String placeOfBirth;
  String dateOfBirth;
  int version;
  String active;
  String createdDate;
  String createdBy;
  String modifiedDate;
  String modifiedBy;
}
