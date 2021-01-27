// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) {
  return ProfileDto(
    json['username'] as String,
    json['name'] as String,
    json['email'] as String,
    json['phoneNumber'] as String,
    json['address'] as String,
    json['country'] as String,
    json['countryCode'] as String,
    json['province'] as String,
    json['provinceCode'] as String,
    json['city'] as String,
    json['cityCode'] as String,
    json['district'] as String,
    json['districtCode'] as String,
    json['subDistrict'] as String,
    json['subDistrictCode'] as String,
    json['zipcode'] as String,
    json['image'] as String,
    json['description'] as String,
    json['idNumber'] as String,
    json['age'] as int,
    json['gender'] as String,
    json['genderCode'] as String,
    json['placeOfBirth'] as String,
    json['dateOfBirth'] as String,
    json['version'] as int,
    json['active'] as String,
    json['createdDate'] as String,
    json['createdBy'] as String,
    json['modifiedDate'] as String,
    json['modifiedBy'] as String,
  );
}

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'province': instance.province,
      'provinceCode': instance.provinceCode,
      'city': instance.city,
      'cityCode': instance.cityCode,
      'district': instance.district,
      'districtCode': instance.districtCode,
      'subDistrict': instance.subDistrict,
      'subDistrictCode': instance.subDistrictCode,
      'zipcode': instance.zipcode,
      'image': instance.image,
      'description': instance.description,
      'idNumber': instance.idNumber,
      'age': instance.age,
      'gender': instance.gender,
      'genderCode': instance.genderCode,
      'placeOfBirth': instance.placeOfBirth,
      'dateOfBirth': instance.dateOfBirth,
      'version': instance.version,
      'active': instance.active,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
    };
