part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object> get props => [];
}

class RequestedEvent extends BookmarksEvent {
  const RequestedEvent();
}
