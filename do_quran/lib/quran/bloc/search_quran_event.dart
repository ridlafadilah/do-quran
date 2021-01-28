part of 'search_quran_bloc.dart';

class SurahChanged extends CommonEvent {
  const SurahChanged(this.surah);

  final String surah;

  @override
  List<Object> get props => [surah];
}

class SearchQuranEvent extends CommonEvent {
  const SearchQuranEvent();
}
