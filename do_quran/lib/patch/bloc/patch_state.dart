part of 'patch_bloc.dart';

abstract class PatchState extends Equatable {
  const PatchState();

  @override
  List<Object> get props => [];
}

class InitialState extends PatchState {}

class RequestInProgressState extends PatchState {
  const RequestInProgressState({this.status});

  final String status;

  @override
  List<String> get props => [status];
}

class RequestSuccessState extends PatchState {}

class RequestFailureState extends PatchState {
  const RequestFailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request State Failure { error: $error }';
}

class PatchInProgressState extends PatchState {}

class PatchSuccessState extends PatchState {}

class PatchFailureState extends PatchState {
  const PatchFailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Patch State Failure { error: $error }';
}
