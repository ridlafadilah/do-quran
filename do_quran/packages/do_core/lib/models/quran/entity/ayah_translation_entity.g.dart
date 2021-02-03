// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_translation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AyahTranslationEntity _$AyahTranslationEntityFromJson(
    Map<String, dynamic> json) {
  return AyahTranslationEntity(
    id: json['id'] as int,
    nameLatinSurah: json['name_latin_surah'] as String,
    numberOfAyah: json['number_of_ayah'] as String,
    text: json['text'] as String,
    l10n: json['l10n'] as String,
    idSurah: json['id_surah'] as String,
  );
}

Map<String, dynamic> _$AyahTranslationEntityToJson(
        AyahTranslationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_latin_surah': instance.nameLatinSurah,
      'number_of_ayah': instance.numberOfAyah,
      'text': instance.text,
      'l10n': instance.l10n,
      'id_surah': instance.idSurah,
    };
