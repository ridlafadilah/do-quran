part of 'search_quran_bloc.dart';

class SearchQuranState extends Equatable {
  const SearchQuranState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.surah = const SurahField.pure(),
    this.quran,
    this.ayat,
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final SurahField surah;
  final List<QuranInfo> quran;
  final int ayat;

  SearchQuranState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    SurahField surah,
    List<QuranInfo> quran,
    int ayat,
  }) {
    return SearchQuranState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      surah: surah ?? this.surah,
      quran: quran ?? this.quran,
      ayat: ayat ?? this.ayat,
    );
  }

  @override
  List<Object> get props => [status, action, surah, quran, ayat];
}
