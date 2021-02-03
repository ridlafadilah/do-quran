// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafsir.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tafsir _$TafsirFromJson(Map<String, dynamic> json) {
  return Tafsir(
    id: json['id'] == null
        ? null
        : TafsirId.fromJson(json['id'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TafsirToJson(Tafsir instance) => <String, dynamic>{
      'id': instance.id,
    };
