part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object> get props => [];
}

class InitialState extends BookmarksState {}

class RequestInProgressTodayState extends BookmarksState {}

class RequestSuccessTodayState extends BookmarksState {
  const RequestSuccessTodayState({this.pray, this.datetime, this.location});

  final Pray pray;
  final DatetimePray datetime;
  final String location;

  @override
  List<dynamic> get props => [pray, datetime, location];
}

class RequestFailureTodayState extends BookmarksState {
  const RequestFailureTodayState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request Today State Failure { error: $error }';
}

class RequestInProgressWeekState extends BookmarksState {}

class RequestSuccessWeekState extends BookmarksState {
  const RequestSuccessWeekState({this.pray, this.datetime, this.location});

  final Pray pray;
  final DatetimePray datetime;
  final String location;

  @override
  List<dynamic> get props => [pray, datetime, location];
}

class RequestFailureWeekState extends BookmarksState {
  const RequestFailureWeekState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request Week State Failure { error: $error }';
}

class RequestInProgressMonthState extends BookmarksState {}

class RequestSuccessMonthState extends BookmarksState {
  const RequestSuccessMonthState({this.pray, this.datetime, this.location});

  final Pray pray;
  final DatetimePray datetime;
  final String location;

  @override
  List<dynamic> get props => [pray, datetime, location];
}

class RequestFailureMonthState extends BookmarksState {
  const RequestFailureMonthState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request Month State Failure { error: $error }';
}
