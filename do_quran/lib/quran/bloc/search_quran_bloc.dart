import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_core/models/quran/quran_info.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'search_quran_event.dart';
part 'search_quran_state.dart';

class SearchQuranBloc extends Bloc<CommonEvent, SearchQuranState> {
  SearchQuranBloc() : super(const SearchQuranState());
  List<QuranInfo> quran = [];
  @override
  Stream<SearchQuranState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is InitialQuranEvent) {
      quran = await getQuran();
    }
    if (event is SurahChanged) {
      final surah = SurahField.dirty(event.surah);
      final List<String> surahSearch =
          event.surah.toLowerCase().split(RegExp(r'[ :]'));
      int ayatSearch = 1;
      if (surahSearch.length > 1) {
        try {
          ayatSearch = int.parse(surahSearch[1]);
        } catch (e) {}
      }
      int numberOfAyah = 0;
      try {
        numberOfAyah = int.parse(surahSearch[0]);
      } catch (e) {}
      final List<QuranInfo> data = quran
          .where((element) => ((element.index == numberOfAyah &&
                  element.ayahCount >= ayatSearch) ||
              (element.latin.toLowerCase().contains(surahSearch[0]) &&
                  element.ayahCount >= ayatSearch)))
          .toList();
      yield state.copyWith(
        surah: surah,
        quran: data,
        ayat: ayatSearch,
        action: Formz.validate([surah]),
        status: FormzStatus.pure,
        error: null,
      );
    }
  }

  Future<List<QuranInfo>> getQuran() async {
    final QuranInfoDao quranInfoDao = QuranInfoDao();
    final List<QuranInfoEntity> quranEntities = await quranInfoDao.getAll();
    final List<QuranInfo> quranInfoList = [];
    quranEntities.forEach((quran) {
      final QuranInfo quranInfo = QuranInfo(
        translationEnglish: quran.translationEnglish,
        translationIndonesia: quran.translationIndonesia,
        arabic: quran.arabic,
        latin: quran.latin,
        ayahCount: quran.ayahCount,
        index: quran.index,
        opening: quran.opening,
        closing: quran.closing,
      );
      quranInfoList.add(quranInfo);
    });
    return quranInfoList;
  }

  Future<List<QuranInfo>> getData() {
    final QuranService quranService = QuranService();
    return quranService.loadQuran();
  }
}
