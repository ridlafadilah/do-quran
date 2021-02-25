part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object> get props => [];
}

class InitialState extends BookmarksState {}

class RequestInProgressState extends BookmarksState {}

class RequestSuccessState extends BookmarksState {
  const RequestSuccessState({this.verses});

  final List<VersesBookmarks> verses;

  @override
  List<dynamic> get props => [verses];
}

class RequestFailureState extends BookmarksState {
  const RequestFailureState({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Request State Failure { error: $error }';
}
