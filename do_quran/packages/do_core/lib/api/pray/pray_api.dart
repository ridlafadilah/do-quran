import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/models.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:retrofit/http.dart';

part 'pray_api.g.dart';

@RestApi()
abstract class PrayAPI {
  factory PrayAPI(Dio dio) {
    final String baseUrl =
        GlobalConfiguration().getValue('hosts')['pray']['host'];
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    return _PrayAPI(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/json'})
  @GET('/v2/times/{method}.json?latitude={latitude}&longitude={longitude}')
  Future<Pray> getJadwalSalahPosition(
      @Path() String method, @Path() String latitude, @Path() String longitude);

  @Headers({'content-type': 'application/json'})
  @GET('/v2/times/{method}.json?city={city}')
  Future<Pray> getJadwalSalahCity(@Path() String method, @Path() String city);
}
