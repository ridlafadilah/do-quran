import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc() : super(InitialState());

  String latitude;
  String longitude;
  String location;

  @override
  Stream<BookmarksState> mapEventToState(BookmarksEvent event) async* {
    if (event is RequestedTodayEvent) {
      yield RequestInProgressTodayState();
      try {
        await getCurrenyLocation();
        Pray data = await getData(event.method, latitude, longitude);
        DatetimePray datetime = data.results.datetime.firstWhere((element) =>
            element.date.gregorian == DatetimeUtils.getTime('yyyy-MM-dd'));
        yield RequestSuccessTodayState(
            pray: data, datetime: datetime, location: location);
      } on ServerError catch (e) {
        yield RequestFailureTodayState(error: e.getErrorMessage());
      }
    } else if (event is RequestedWeekEvent) {
      yield RequestInProgressWeekState();
      try {
        await getCurrenyLocation();
        Pray data = await getData(event.method, latitude, longitude);
        DatetimePray datetime = data.results.datetime.firstWhere((element) =>
            element.date.gregorian == DatetimeUtils.getTime('yyyy-MM-dd'));
        yield RequestSuccessWeekState(
            pray: data, datetime: datetime, location: location);
      } on ServerError catch (e) {
        yield RequestFailureWeekState(error: e.getErrorMessage());
      }
    } else if (event is RequestedMonthEvent) {
      yield RequestInProgressMonthState();
      try {
        await getCurrenyLocation();
        Pray data = await getData(event.method, latitude, longitude);
        DatetimePray datetime = data.results.datetime.firstWhere((element) =>
            element.date.gregorian == DatetimeUtils.getTime('yyyy-MM-dd'));
        yield RequestSuccessMonthState(
            pray: data, datetime: datetime, location: location);
      } on ServerError catch (e) {
        yield RequestFailureMonthState(error: e.getErrorMessage());
      }
    }
  }

  Future<Pray> getData(String method, String latitude, String longitude) {
    final PrayService prayService = PrayService();
    return prayService.getJadwalSalahPosition(method, latitude, longitude);
  }

  Future<void> getCurrenyLocation() async {
    location ??= 'Jakarta';
  }
}
