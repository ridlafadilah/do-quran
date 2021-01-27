part of 'thememode_bloc.dart';

class ThemeModeState extends CommonState {
  const ThemeModeState({this.themeMode, this.darkMode});

  final ThemeMode themeMode;
  final bool darkMode;

  @override
  List<ThemeMode> get props => [themeMode];
}
