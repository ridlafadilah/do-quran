part of 'common_bloc.dart';

abstract class CommonEvent extends Equatable {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

class RequestedEvent extends CommonEvent {
  const RequestedEvent();
}

class SubmittedEvent<T> extends CommonEvent {
  const SubmittedEvent({this.data});

  final T data;

  @override
  List<Object> get props => [data];
}
