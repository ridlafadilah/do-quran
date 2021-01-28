// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Surah _$SurahFromJson(Map<String, dynamic> json) {
  return Surah(
    json['number'] as String,
    json['name'] as String,
    json['name_latin'] as String,
    json['number_of_ayah'] as String,
    (json['text'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    json['translations'] == null
        ? null
        : Translations.fromJson(json['translations'] as Map<String, dynamic>),
    json['tafsir'] == null
        ? null
        : Tafsir.fromJson(json['tafsir'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SurahToJson(Surah instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'name_latin': instance.nameLatin,
      'number_of_ayah': instance.numberOfAyah,
      'text': instance.text,
      'translations': instance.translations,
      'tafsir': instance.tafsir,
    };
