part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object> get props => [];
}

class RequestedTodayEvent extends BookmarksEvent {
  const RequestedTodayEvent();

  final String method = PrayMethod.today;

  @override
  List<dynamic> get props => [method];
}

class RequestedWeekEvent extends BookmarksEvent {
  const RequestedWeekEvent();

  final String method = PrayMethod.week;

  @override
  List<dynamic> get props => [method];
}

class RequestedMonthEvent extends BookmarksEvent {
  const RequestedMonthEvent();

  final String method = PrayMethod.month;

  @override
  List<dynamic> get props => [method];
}
