part of 'surah_bloc.dart';

abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object> get props => [];
}

class InitialState extends SurahState {}

class RequestInProgressState extends SurahState {}

class RequestSuccessState extends SurahState {
  const RequestSuccessState({this.surah});

  final Surah surah;

  @override
  List<Surah> get props => [surah];
}

class RequestFailureState extends SurahState {
  const RequestFailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request State Failure { error: $error }';
}
