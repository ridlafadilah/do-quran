import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/interceptors/http_basic_interceptors.dart';
import 'package:do_core/interceptors/http_language_interceptors.dart';
import 'package:do_core/models.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:retrofit/http.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthAPI {
  factory AuthAPI(Dio dio) {
    final String baseUrl =
        GlobalConfiguration().getValue('hosts')['auth']['host'];
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(HttpBasicInterceptors());
    dio.interceptors.add(HttpLanguageInterceptors());
    return _AuthAPI(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/json'})
  @POST('/do/oauth/signup')
  Future<BaseResponse> signup(@Body() Map<String, dynamic> body);

  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  @POST('/do/oauth/token')
  Future<OAuthResult> token(@Body() Map<String, dynamic> body);

  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  @POST('/do/oauth/token-verifier')
  Future<OAuthResult> tokenVerifier(@Body() Map<String, dynamic> body);

  @Headers({'content-type': 'application/json'})
  @POST('/do/oauth/request-forgot-password')
  Future<BaseResponse> requestForgotPassword(@Body() Map<String, dynamic> body);

  @Headers({'content-type': 'application/json'})
  @POST('/do/oauth/verification-forgot-password')
  Future<BaseResponse> verificationForgotPassword(
      @Body() Map<String, dynamic> body);

  @Headers({'content-type': 'application/json'})
  @POST('/do/oauth/forgot-password')
  Future<BaseResponse> forgotPassword(@Body() Map<String, dynamic> body);
}
