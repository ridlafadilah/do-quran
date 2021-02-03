import 'package:do_core/core.dart';
import 'package:do_core/models.dart';

class SurahModulePatch extends CommonModulePatch {
  SurahModulePatch({this.numberOfSurah, this.totalAyah, description})
      : super(description: description);

  final int numberOfSurah;
  final int totalAyah;
  final SurahDao surahDao = SurahDao();

  @override
  Future<bool> doCheck() async {
    int count = await surahDao.countSurah(numberOfSurah);
    return count == totalAyah ?? false;
  }

  @override
  Future doProcess() async {
    Surah _surah = await getSurah(numberOfSurah);
    await surahDao.deleteSurah(numberOfSurah);
    SurahEntity surahEntity = SurahEntity(
        number: _surah.number,
        name: _surah.name,
        nameLatin: _surah.nameLatin,
        totalAyah: _surah.numberOfAyah);
    List<AyahEntity> ayahEntityList = [];
    _surah.text.forEach((key, value) {
      final AyahEntity ayah =
          AyahEntity(idSurah: _surah.number, numberOfAyah: key, text: value);
      ayahEntityList.add(ayah);
    });
    List<AyahTranslationEntity> ayahTranslationEntityList = [];
    _surah.translations.id.text.forEach((key, value) {
      final AyahTranslationEntity ayahTranslation = AyahTranslationEntity(
          idSurah: _surah.number, numberOfAyah: key, text: value);
      ayahTranslationEntityList.add(ayahTranslation);
    });
    surahEntity.ayah = ayahEntityList;
    surahEntity.translations = ayahTranslationEntityList;
    // ignore: unawaited_futures
    surahDao.save(surahEntity);
  }

  Future<Surah> getSurah(int surah) {
    final QuranService quranService = QuranService();
    return quranService.downloadSurah(surah);
  }
}
