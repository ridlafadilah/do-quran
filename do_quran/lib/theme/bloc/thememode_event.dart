part of 'thememode_bloc.dart';

class ThemeModeEvent extends CommonEvent {
  const ThemeModeEvent();
}

class SubmittedEvent extends CommonEvent {
  const SubmittedEvent({this.data});

  final bool data;

  @override
  List<bool> get props => [data];
}
