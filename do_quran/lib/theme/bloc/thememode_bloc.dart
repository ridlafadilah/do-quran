import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'thememode_event.dart';
part 'thememode_state.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeModeState> {
  ThemeModeBloc()
      : super(
            const ThemeModeState(themeMode: ThemeMode.light, darkMode: false));
  final ThemeService themeService = ThemeService();

  @override
  Stream<ThemeModeState> mapEventToState(ThemeModeEvent event) async* {
    final bool darkMode = themeService.getData();
    if (darkMode) {
      yield const ThemeModeState(themeMode: ThemeMode.dark, darkMode: true);
    } else {
      yield const ThemeModeState(themeMode: ThemeMode.light, darkMode: false);
    }
  }
}
