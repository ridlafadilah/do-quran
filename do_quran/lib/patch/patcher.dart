import 'package:do_core/core.dart';
import 'package:do_quran/patch/services/quran_module_patch.dart';
import 'package:do_quran/patch/services/surah_module_patch.dart';

class Patcher {
  static final List<CommonModulePatch> listPatches = [
    QuranModulePatch(),
    SurahModulePatch(numberOfSurah: 1, totalAyah: 7, description: 'Al-Fatihah'),
    SurahModulePatch(
        numberOfSurah: 2, totalAyah: 286, description: 'Al-Baqarah'),
    SurahModulePatch(
        numberOfSurah: 3, totalAyah: 200, description: 'Ali \'Imran'),
    SurahModulePatch(
        numberOfSurah: 4, totalAyah: 176, description: 'An-Nisa\''),
    SurahModulePatch(
        numberOfSurah: 5, totalAyah: 120, description: 'Al-Ma\'idah'),
    SurahModulePatch(
        numberOfSurah: 6, totalAyah: 165, description: 'Al-An\'am'),
    SurahModulePatch(
        numberOfSurah: 7, totalAyah: 206, description: 'Al-A\'raf'),
    SurahModulePatch(numberOfSurah: 8, totalAyah: 75, description: 'Al-Anfal'),
    SurahModulePatch(
        numberOfSurah: 9, totalAyah: 129, description: 'At-Taubah'),
    SurahModulePatch(numberOfSurah: 10, totalAyah: 109, description: 'Yunus'),
    SurahModulePatch(numberOfSurah: 11, totalAyah: 123, description: 'Hud'),
    SurahModulePatch(numberOfSurah: 12, totalAyah: 111, description: 'Yusuf'),
    SurahModulePatch(numberOfSurah: 13, totalAyah: 43, description: 'Ar-Ra\'d'),
    SurahModulePatch(numberOfSurah: 14, totalAyah: 52, description: 'Ibrahim'),
    SurahModulePatch(numberOfSurah: 15, totalAyah: 99, description: 'Al-Hijr'),
    SurahModulePatch(numberOfSurah: 16, totalAyah: 128, description: 'An-Nahl'),
    SurahModulePatch(
        numberOfSurah: 17, totalAyah: 111, description: 'Al-Isra\''),
    SurahModulePatch(numberOfSurah: 18, totalAyah: 110, description: 'Al-Kahf'),
    SurahModulePatch(numberOfSurah: 19, totalAyah: 98, description: 'Maryam'),
    SurahModulePatch(numberOfSurah: 20, totalAyah: 135, description: 'Taha'),
    SurahModulePatch(
        numberOfSurah: 21, totalAyah: 112, description: 'Al-Anbiya\''),
    SurahModulePatch(numberOfSurah: 22, totalAyah: 78, description: 'Al-Hajj'),
    SurahModulePatch(
        numberOfSurah: 23, totalAyah: 118, description: 'Al-Mu\'minun'),
    SurahModulePatch(numberOfSurah: 24, totalAyah: 64, description: 'An-Nur'),
    SurahModulePatch(
        numberOfSurah: 25, totalAyah: 77, description: 'Al-Furqan'),
    SurahModulePatch(
        numberOfSurah: 26, totalAyah: 227, description: 'Asy-Syu\'ara\''),
    SurahModulePatch(numberOfSurah: 27, totalAyah: 93, description: 'An-Naml'),
    SurahModulePatch(numberOfSurah: 28, totalAyah: 88, description: 'Al-Qasas'),
    SurahModulePatch(
        numberOfSurah: 29, totalAyah: 69, description: 'Al-\'Ankabut'),
    SurahModulePatch(numberOfSurah: 30, totalAyah: 60, description: 'Ar-Rum'),
    SurahModulePatch(numberOfSurah: 31, totalAyah: 34, description: 'Luqman'),
    SurahModulePatch(
        numberOfSurah: 32, totalAyah: 30, description: 'As-Sajdah'),
    SurahModulePatch(numberOfSurah: 33, totalAyah: 73, description: 'Al-Ahzab'),
    SurahModulePatch(numberOfSurah: 34, totalAyah: 54, description: 'Saba\''),
    SurahModulePatch(numberOfSurah: 35, totalAyah: 45, description: 'Fatir'),
    SurahModulePatch(numberOfSurah: 36, totalAyah: 83, description: 'Yasin'),
    SurahModulePatch(
        numberOfSurah: 37, totalAyah: 182, description: 'As-Saffat'),
    SurahModulePatch(numberOfSurah: 38, totalAyah: 88, description: 'Sad'),
    SurahModulePatch(numberOfSurah: 39, totalAyah: 75, description: 'Az-Zumar'),
    SurahModulePatch(numberOfSurah: 40, totalAyah: 85, description: 'Gafir'),
    SurahModulePatch(numberOfSurah: 41, totalAyah: 54, description: 'Fussilat'),
    SurahModulePatch(
        numberOfSurah: 42, totalAyah: 53, description: 'Asy-Syura'),
    SurahModulePatch(
        numberOfSurah: 43, totalAyah: 89, description: 'Az-Zukhruf'),
    SurahModulePatch(
        numberOfSurah: 44, totalAyah: 59, description: 'Ad-Dukhan'),
    SurahModulePatch(
        numberOfSurah: 45, totalAyah: 37, description: 'Al-Jasiyah'),
    SurahModulePatch(numberOfSurah: 46, totalAyah: 35, description: 'Al-Ahqaf'),
    SurahModulePatch(numberOfSurah: 47, totalAyah: 38, description: 'Muhammad'),
    SurahModulePatch(numberOfSurah: 48, totalAyah: 29, description: 'Al-Fath'),
    SurahModulePatch(
        numberOfSurah: 49, totalAyah: 18, description: 'Al-Hujurat'),
    SurahModulePatch(numberOfSurah: 50, totalAyah: 45, description: 'Qaf'),
    SurahModulePatch(
        numberOfSurah: 51, totalAyah: 60, description: 'Az-Zariyat'),
    SurahModulePatch(numberOfSurah: 52, totalAyah: 49, description: 'At-Tur'),
    SurahModulePatch(numberOfSurah: 53, totalAyah: 62, description: 'An-Najm'),
    SurahModulePatch(numberOfSurah: 54, totalAyah: 55, description: 'Al-Qamar'),
    SurahModulePatch(
        numberOfSurah: 55, totalAyah: 78, description: 'Ar-Rahman'),
    SurahModulePatch(
        numberOfSurah: 56, totalAyah: 96, description: 'Al-Waqi\'ah'),
    SurahModulePatch(numberOfSurah: 57, totalAyah: 29, description: 'Al-Hadid'),
    SurahModulePatch(
        numberOfSurah: 58, totalAyah: 22, description: 'Al-Mujadalah'),
    SurahModulePatch(numberOfSurah: 59, totalAyah: 24, description: 'Al-Hasyr'),
    SurahModulePatch(
        numberOfSurah: 60, totalAyah: 13, description: 'Al-Mumtahanah'),
    SurahModulePatch(numberOfSurah: 61, totalAyah: 14, description: 'As-Saff'),
    SurahModulePatch(
        numberOfSurah: 62, totalAyah: 11, description: 'Al-Jumu\'ah'),
    SurahModulePatch(
        numberOfSurah: 63, totalAyah: 11, description: 'Al-Munafiqun'),
    SurahModulePatch(
        numberOfSurah: 64, totalAyah: 18, description: 'At-Tagabun'),
    SurahModulePatch(numberOfSurah: 65, totalAyah: 12, description: 'At-Talaq'),
    SurahModulePatch(
        numberOfSurah: 66, totalAyah: 12, description: 'At-Tahrim'),
    SurahModulePatch(numberOfSurah: 67, totalAyah: 30, description: 'Al-Mulk'),
    SurahModulePatch(numberOfSurah: 68, totalAyah: 52, description: 'Al-Qalam'),
    SurahModulePatch(
        numberOfSurah: 69, totalAyah: 52, description: 'Al-Haqqah'),
    SurahModulePatch(
        numberOfSurah: 70, totalAyah: 44, description: 'Al-Ma\'arij'),
    SurahModulePatch(numberOfSurah: 71, totalAyah: 28, description: 'Nuh'),
    SurahModulePatch(numberOfSurah: 72, totalAyah: 28, description: 'Al-Jinn'),
    SurahModulePatch(
        numberOfSurah: 73, totalAyah: 20, description: 'Al-Muzzammil'),
    SurahModulePatch(
        numberOfSurah: 74, totalAyah: 56, description: 'Al-Muddassir'),
    SurahModulePatch(
        numberOfSurah: 75, totalAyah: 40, description: 'Al-Qiyamah'),
    SurahModulePatch(numberOfSurah: 76, totalAyah: 31, description: 'Al-Insan'),
    SurahModulePatch(
        numberOfSurah: 77, totalAyah: 50, description: 'Al-Mursalat'),
    SurahModulePatch(
        numberOfSurah: 78, totalAyah: 40, description: 'An-Naba\''),
    SurahModulePatch(
        numberOfSurah: 79, totalAyah: 46, description: 'An-Nazi\'at'),
    SurahModulePatch(numberOfSurah: 80, totalAyah: 42, description: '\'Abasa'),
    SurahModulePatch(
        numberOfSurah: 81, totalAyah: 29, description: 'At-Takwir'),
    SurahModulePatch(
        numberOfSurah: 82, totalAyah: 19, description: 'Al-Infitar'),
    SurahModulePatch(
        numberOfSurah: 83, totalAyah: 36, description: 'Al-Mutaffifin'),
    SurahModulePatch(
        numberOfSurah: 84, totalAyah: 25, description: 'Al-Insyiqaq'),
    SurahModulePatch(numberOfSurah: 85, totalAyah: 22, description: 'Al-Buruj'),
    SurahModulePatch(numberOfSurah: 86, totalAyah: 17, description: 'At-Tariq'),
    SurahModulePatch(numberOfSurah: 87, totalAyah: 19, description: 'Al-A\'la'),
    SurahModulePatch(
        numberOfSurah: 88, totalAyah: 26, description: 'Al-Gasyiyah'),
    SurahModulePatch(numberOfSurah: 89, totalAyah: 30, description: 'Al-Fajr'),
    SurahModulePatch(numberOfSurah: 90, totalAyah: 20, description: 'Al-Balad'),
    SurahModulePatch(
        numberOfSurah: 91, totalAyah: 15, description: 'Asy-Syams'),
    SurahModulePatch(numberOfSurah: 92, totalAyah: 21, description: 'Al-Lail'),
    SurahModulePatch(numberOfSurah: 93, totalAyah: 11, description: 'Ad-Duha'),
    SurahModulePatch(numberOfSurah: 94, totalAyah: 8, description: 'Asy-Syarh'),
    SurahModulePatch(numberOfSurah: 95, totalAyah: 8, description: 'At-Tin'),
    SurahModulePatch(
        numberOfSurah: 96, totalAyah: 19, description: 'Al-\'Alaq'),
    SurahModulePatch(numberOfSurah: 97, totalAyah: 5, description: 'Al-Qadr'),
    SurahModulePatch(
        numberOfSurah: 98, totalAyah: 8, description: 'Al-Bayyinah'),
    SurahModulePatch(
        numberOfSurah: 99, totalAyah: 8, description: 'Az-Zalzalah'),
    SurahModulePatch(
        numberOfSurah: 100, totalAyah: 11, description: 'Al-\'Adiyat'),
    SurahModulePatch(
        numberOfSurah: 101, totalAyah: 11, description: 'Al-Qari\'ah'),
    SurahModulePatch(
        numberOfSurah: 102, totalAyah: 8, description: 'At-Takasur'),
    SurahModulePatch(numberOfSurah: 103, totalAyah: 3, description: 'Al-\'Asr'),
    SurahModulePatch(
        numberOfSurah: 104, totalAyah: 9, description: 'Al-Humazah'),
    SurahModulePatch(numberOfSurah: 105, totalAyah: 5, description: 'Al-Fil'),
    SurahModulePatch(numberOfSurah: 106, totalAyah: 4, description: 'Quraisy'),
    SurahModulePatch(
        numberOfSurah: 107, totalAyah: 7, description: 'Al-Ma\'un'),
    SurahModulePatch(
        numberOfSurah: 108, totalAyah: 3, description: 'Al-Kausar'),
    SurahModulePatch(
        numberOfSurah: 109, totalAyah: 6, description: 'Al-Kafirun'),
    SurahModulePatch(numberOfSurah: 110, totalAyah: 3, description: 'An-Nasr'),
    SurahModulePatch(numberOfSurah: 111, totalAyah: 5, description: 'Al-Lahab'),
    SurahModulePatch(
        numberOfSurah: 112, totalAyah: 4, description: 'Al-Ikhlas'),
    SurahModulePatch(numberOfSurah: 113, totalAyah: 5, description: 'Al-Falaq'),
    SurahModulePatch(numberOfSurah: 114, totalAyah: 6, description: 'An-Nas'),
  ];
}
