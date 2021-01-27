part of 'quran_bloc.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}

class RequestedEvent extends QuranEvent {
  const RequestedEvent();
}
