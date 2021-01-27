import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_quran/model/quran/quran_info.dart';
import 'package:do_quran/services/quran_service.dart';
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
        List<QuranInfo> data = await getData();
        yield RequestSuccessState(quran: data);
      } on ServerError catch (e) {
        yield RequestFailureState(error: e.getErrorMessage());
      }
    }
  }

  Future<List<QuranInfo>> getData() {
    final QuranService quranService = QuranService();
    return quranService.loadQuran();
  }
}
