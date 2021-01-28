import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'search_quran_event.dart';
part 'search_quran_state.dart';

class SearchQuranBloc extends Bloc<CommonEvent, SearchQuranState> {
  SearchQuranBloc() : super(const SearchQuranState());

  @override
  Stream<SearchQuranState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is SurahChanged) {
      yield _mapSurahChangedToState(event, state);
    }
  }

  SearchQuranState _mapSurahChangedToState(
    SurahChanged event,
    SearchQuranState state,
  ) {
    final surah = SurahField.dirty(event.surah);
    return state.copyWith(
      surah: surah,
      action: Formz.validate([surah]),
      status: FormzStatus.pure,
      error: null,
    );
  }
}
