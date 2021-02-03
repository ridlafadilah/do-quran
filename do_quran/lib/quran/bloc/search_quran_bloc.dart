import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
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
      quran = await getData();
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
      final List<QuranInfo> data = quran
          .where((element) =>
              element.latin.toLowerCase().contains(surahSearch[0]) &&
              element.ayahCount >= ayatSearch)
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

  Future<List<QuranInfo>> getData() {
    final QuranService quranService = QuranService();
    return quranService.loadQuran();
  }
}
