// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafsir_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TafsirId _$TafsirIdFromJson(Map<String, dynamic> json) {
  return TafsirId(
    json['kemenag'] == null
        ? null
        : Kemenag.fromJson(json['kemenag'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TafsirIdToJson(TafsirId instance) => <String, dynamic>{
      'kemenag': instance.kemenag,
    };
