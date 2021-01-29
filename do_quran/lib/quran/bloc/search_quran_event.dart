part of 'search_quran_bloc.dart';

class InitialQuranEvent extends CommonEvent {
  const InitialQuranEvent();
}

class SurahChanged extends CommonEvent {
  const SurahChanged(this.surah);

  final String surah;

  @override
  List<Object> get props => [surah];
}

class SearchQuranEvent extends CommonEvent {
  const SearchQuranEvent();
}
