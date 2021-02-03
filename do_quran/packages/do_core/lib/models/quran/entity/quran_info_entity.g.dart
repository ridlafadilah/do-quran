// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranInfoEntity _$QuranInfoEntityFromJson(Map<String, dynamic> json) {
  return QuranInfoEntity(
    translationIndonesia: json['translation_id'] as String,
    translationEnglish: json['translation_en'] as String,
    arabic: json['arabic'] as String,
    latin: json['latin'] as String,
    ayahCount: json['ayah_count'] as int,
    index: json['idx'] as int,
    opening: json['opening'] as String,
    closing: json['closing'] as String,
  );
}

Map<String, dynamic> _$QuranInfoEntityToJson(QuranInfoEntity instance) =>
    <String, dynamic>{
      'translation_id': instance.translationIndonesia,
      'translation_en': instance.translationEnglish,
      'arabic': instance.arabic,
      'latin': instance.latin,
      'ayah_count': instance.ayahCount,
      'idx': instance.index,
      'opening': instance.opening,
      'closing': instance.closing,
    };
