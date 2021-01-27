import 'dart:convert';

import 'package:do_quran/model/quran/quran_info.dart';
import 'package:do_quran/model/quran/surah.dart';
import 'package:flutter/services.dart';

class QuranService {
  static String pathSurah = 'assets/surah/';
  final String fileQuranInfo = '${pathSurah}quran.json';
  final String timesShalat = 'https://api.pray.zone/v2/times/today.json?city=';

  Future<List<QuranInfo>> loadQuran() async {
    var response = await rootBundle.loadString(fileQuranInfo);
    Iterable data = json.decode(response);
    return data.map((model) => QuranInfo.fromJson(model)).toList();
  }

  Future<Surah> loadSurah(int numberOfSurah) async {
    var response = await rootBundle.loadString('$pathSurah$numberOfSurah.json');
    var res = json.decode(response);
    var data = res['$numberOfSurah'];
    return Surah.fromJson(data);
  }
}
