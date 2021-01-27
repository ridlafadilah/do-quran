import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_quran/model/quran/surah.dart';
import 'package:do_quran/services/quran_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(InitialState());

  @override
  Stream<SurahState> mapEventToState(SurahEvent event) async* {
    if (event is RequestedEvent) {
      yield RequestInProgressState();
      try {
        Surah data = await getData(event.numberOfSurah);
        yield RequestSuccessState(surah: data);
      } on ServerError catch (e) {
        yield RequestFailureState(error: e.getErrorMessage());
      }
    }
  }

  Future<Surah> getData(int numberOfSurah) {
    final QuranService quranService = QuranService();
    return quranService.loadSurah(numberOfSurah);
  }
}
