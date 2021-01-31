// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_translation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahTranslationEntity _$AyahTranslationEntityFromJson(
    Map<String, dynamic> json) {
  return AyahTranslationEntity(
    json['id'] as int,
    json['number_of_ayah'] as String,
    json['text'] as String,
    json['l10n'] as String,
    json['id_surah'] as String,
  );
}

Map<String, dynamic> _$AyahTranslationEntityToJson(
        AyahTranslationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number_of_ayah': instance.numberOfAyah,
      'text': instance.text,
      'l10n': instance.l10n,
      'id_surah': instance.idSurah,
    };
