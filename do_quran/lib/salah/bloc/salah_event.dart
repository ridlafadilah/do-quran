part of 'salah_bloc.dart';

abstract class SalahEvent extends Equatable {
  const SalahEvent();

  @override
  List<Object> get props => [];
}

class RequestedTodayEvent extends SalahEvent {
  const RequestedTodayEvent();

  final String method = PrayMethod.today;

  @override
  List<dynamic> get props => [method];
}

class RequestedWeekEvent extends SalahEvent {
  const RequestedWeekEvent();

  final String method = PrayMethod.week;

  @override
  List<dynamic> get props => [method];
}

class RequestedMonthEvent extends SalahEvent {
  const RequestedMonthEvent();

  final String method = PrayMethod.month;

  @override
  List<dynamic> get props => [method];
}
