part of 'thememode_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeModeState extends ThemeState {
  const ThemeModeState({this.themeMode, this.darkMode});

  final ThemeMode themeMode;
  final bool darkMode;

  @override
  List<ThemeMode> get props => [themeMode];
}

class SubmitInProgressState extends ThemeState {}

class SubmitSuccessState extends ThemeState {
  const SubmitSuccessState({this.data});

  final bool data;

  @override
  List<bool> get props => [data];
}

class SubmitFailureState extends ThemeState {
  const SubmitFailureState({this.error});

  final String error;

  @override
  List<String> get props => [error];

  @override
  String toString() => 'Request State Failure { error: $error }';
}
