part of 'surah_bloc.dart';

abstract class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object> get props => [];
}

class RequestedEvent extends SurahEvent {
  const RequestedEvent({this.numberOfSurah});

  final int numberOfSurah;

  @override
  List<int> get props => [numberOfSurah];
}
