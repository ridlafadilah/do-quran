import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'thememode_event.dart';
part 'thememode_state.dart';

class ThemeModeBloc extends Bloc<CommonEvent, ThemeState> {
  ThemeModeBloc()
      : super(
            const ThemeModeState(themeMode: ThemeMode.light, darkMode: false));
  final ThemeService themeService = ThemeService();

  @override
  Stream<ThemeState> mapEventToState(CommonEvent event) async* {
    if (event is ThemeModeEvent) {
      final bool darkMode = themeService.getData();
      if (darkMode) {
        yield const ThemeModeState(themeMode: ThemeMode.dark, darkMode: true);
      } else {
        yield const ThemeModeState(themeMode: ThemeMode.light, darkMode: false);
      }
    } else if (event is SubmittedEvent) {
      yield SubmitInProgressState();
      try {
        bool data = await themeService.putDataSharedPreferences(event.data);
        yield SubmitSuccessState(data: data);
      } catch (e) {
        yield SubmitFailureState(error: e.getErrorMessage());
      }
    }
  }
}
