// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Surah _$SurahFromJson(Map<String, dynamic> json) {
  return Surah(
    number: json['number'] as String,
    name: json['name'] as String,
    nameLatin: json['name_latin'] as String,
    numberOfAyah: json['number_of_ayah'] as String,
    text: (json['text'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    translations: json['translations'] == null
        ? null
        : Translations.fromJson(json['translations'] as Map<String, dynamic>),
    tafsir: json['tafsir'] == null
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
