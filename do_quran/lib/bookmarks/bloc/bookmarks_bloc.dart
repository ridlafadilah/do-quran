import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_core/services/bookmarks_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc() : super(InitialState());

  final BookmarksService bookmarksService = BookmarksService();

  @override
  Stream<BookmarksState> mapEventToState(BookmarksEvent event) async* {
    if (event is RequestedEvent) {
      yield RequestInProgressState();
      try {
        List<VersesBookmarks> verses = await bookmarksService.getBookmarks();
        yield RequestSuccessState(verses: verses);
      } on ServerError catch (e) {
        yield RequestFailureState(error: e.getErrorMessage());
      }
    }
  }
}
