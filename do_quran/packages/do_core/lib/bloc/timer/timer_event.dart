part of 'timer_bloc.dart';

class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({@required this.duration});

  final int duration;

  @override
  String toString() => 'Timer Started { duration: $duration }';
}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent {
  const TimerTicked({@required this.duration});

  final int duration;

  @override
  List<Object> get props => [duration];

  @override
  String toString() => 'Timer Ticked { duration: $duration }';
}
