import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  QuranBloc() : super(InitialState());

  @override
  Stream<QuranState> mapEventToState(QuranEvent event) async* {
    if (event is RequestedEvent) {
      yield RequestInProgressState();
      try {
        final List<QuranInfo> data = await getQuran();
        yield RequestSuccessState(quran: data);
      } on ServerError catch (e) {
        yield RequestFailureState(error: e.getErrorMessage());
      }
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
