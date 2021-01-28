import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'salah_event.dart';
part 'salah_state.dart';

class SalahBloc extends Bloc<SalahEvent, SalahState> {
  SalahBloc() : super(InitialState());

  String latitude;
  String longitude;
  String location;

  @override
  Stream<SalahState> mapEventToState(SalahEvent event) async* {
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
    try {
      Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
          .then((value) async {
        List<Placemark> daftarPlace = await geolocator.placemarkFromCoordinates(
            value.latitude, value.longitude);
        Placemark place = daftarPlace[0];
        location = place.locality;
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
      }).catchError((e) {});
    } catch (error) {}
    if (location == null) {
      location = 'Jakarta';
    }
  }
}
