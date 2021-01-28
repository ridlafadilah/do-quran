part of 'salah_bloc.dart';

abstract class SalahState extends Equatable {
  const SalahState();

  @override
  List<Object> get props => [];
}

class InitialState extends SalahState {}

class RequestInProgressTodayState extends SalahState {}

class RequestSuccessTodayState extends SalahState {
  const RequestSuccessTodayState({this.pray, this.datetime, this.location});

  final Pray pray;
  final DatetimePray datetime;
  final String location;

  @override
  List<dynamic> get props => [pray, datetime, location];
}

class RequestFailureTodayState extends SalahState {
  const RequestFailureTodayState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request Today State Failure { error: $error }';
}

class RequestInProgressWeekState extends SalahState {}

class RequestSuccessWeekState extends SalahState {
  const RequestSuccessWeekState({this.pray, this.datetime, this.location});

  final Pray pray;
  final DatetimePray datetime;
  final String location;

  @override
  List<dynamic> get props => [pray, datetime, location];
}

class RequestFailureWeekState extends SalahState {
  const RequestFailureWeekState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request Week State Failure { error: $error }';
}

class RequestInProgressMonthState extends SalahState {}

class RequestSuccessMonthState extends SalahState {
  const RequestSuccessMonthState({this.pray, this.datetime, this.location});

  final Pray pray;
  final DatetimePray datetime;
  final String location;

  @override
  List<dynamic> get props => [pray, datetime, location];
}

class RequestFailureMonthState extends SalahState {
  const RequestFailureMonthState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request Month State Failure { error: $error }';
}
