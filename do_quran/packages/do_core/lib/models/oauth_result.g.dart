// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthResult _$OAuthResultFromJson(Map<String, dynamic> json) {
  return OAuthResult(
    json['access_token'] as String,
    json['refresh_token'] as String,
    json['token_type'] as String,
    json['xrkey'] as String,
    json['expires_in'] as int,
    json['authority'] as String,
    json['provider'] as String,
    json['image'] as String,
    json['email'] as String,
    json['menus'],
    json['extras'],
    json['server_date'] as String,
    json['locale'] as String,
    json['theme'] as String,
    json['name'] as String,
    json['username'] as String,
  );
}

Map<String, dynamic> _$OAuthResultToJson(OAuthResult instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'xrkey': instance.publicKey,
      'expires_in': instance.expiresIn,
      'authority': instance.authority,
      'provider': instance.provider,
      'image': instance.image,
      'email': instance.email,
      'menus': instance.menus,
      'extras': instance.extras,
      'server_date': instance.serverDate,
      'locale': instance.locale,
      'theme': instance.theme,
      'name': instance.name,
      'username': instance.username,
    };
