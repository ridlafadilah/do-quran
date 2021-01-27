part of 'quran_bloc.dart';

abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

class InitialState extends QuranState {}

class RequestInProgressState extends QuranState {}

class RequestSuccessState extends QuranState {
  const RequestSuccessState({this.quran});

  final List<QuranInfo> quran;

  @override
  List<List<QuranInfo>> get props => [quran];
}

class RequestFailureState extends QuranState {
  const RequestFailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request State Failure { error: $error }';
}
