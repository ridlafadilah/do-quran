import 'dart:convert';

import 'package:do_core/models/quran/quran_info.dart';
import 'package:do_core/models/quran/surah.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class QuranService {
  QuranService() {
    baseUrl = GlobalConfiguration().getValue('hosts')['quran']['host'];
  }
  static String pathSurah = 'assets/surah/';
  final String fileQuranInfo = '${pathSurah}quran.json';
  String baseUrl;

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

  Future<List<QuranInfo>> downloadQuran() async {
    var response = await http.get('$baseUrl/do-quran/quran.json');
    Iterable data = json.decode(response.body);
    return data.map((model) => QuranInfo.fromJson(model)).toList();
  }

  Future<Surah> downloadSurah(int numberOfSurah) async {
    final String apiSurah = '$baseUrl/do-quran/surah/$numberOfSurah.json';
    var response = await http.get(apiSurah);
    var res = json.decode(response.body);
    var data = res['$numberOfSurah'];
    return Surah.fromJson(data);
  }
}
