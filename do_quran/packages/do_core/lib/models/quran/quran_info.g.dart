// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranInfo _$QuranInfoFromJson(Map<String, dynamic> json) {
  return QuranInfo(
    translationIndonesia: json['translation_id'] as String,
    translationEnglish: json['translation_en'] as String,
    arabic: json['arabic'] as String,
    latin: json['latin'] as String,
    ayahCount: json['ayah_count'] as int,
    index: json['index'] as int,
    opening: json['opening'] as String,
    closing: json['closing'] as String,
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
