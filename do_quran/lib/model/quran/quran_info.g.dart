// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranInfo _$QuranInfoFromJson(Map<String, dynamic> json) {
  return QuranInfo(
    json['translation_id'] as String,
    json['translation_en'] as String,
    json['arabic'] as String,
    json['latin'] as String,
    json['ayah_count'] as int,
    json['index'] as int,
    json['opening'] as String,
    json['closing'] as String,
  );
}

Map<String, dynamic> _$QuranInfoToJson(QuranInfo instance) => <String, dynamic>{
      'translation_id': instance.translationIndonesia,
      'translation_en': instance.translationEnglish,
      'arabic': instance.arabic,
      'latin': instance.latin,
      'ayah_count': instance.ayahCount,
      'index': instance.index,
      'opening': instance.opening,
      'closing': instance.closing,
    };
