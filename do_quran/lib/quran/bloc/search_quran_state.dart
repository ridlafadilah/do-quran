part of 'search_quran_bloc.dart';

class SearchQuranState extends Equatable {
  const SearchQuranState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.surah = const SurahField.pure(),
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final SurahField surah;

  SearchQuranState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    SurahField surah,
  }) {
    return SearchQuranState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      surah: surah ?? this.surah,
    );
  }

  @override
  List<Object> get props => [status, action, surah];
}
