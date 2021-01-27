import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/interceptors/http_error_interceptors.dart';
import 'package:do_core/interceptors/http_language_interceptors.dart';
import 'package:do_core/interceptors/http_oauth_interceptors.dart';
import 'package:do_core/interceptors/http_signature_interceptors.dart';
import 'package:do_core/models.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:retrofit/retrofit.dart';

part 'security_api.g.dart';

@RestApi()
abstract class SecurityAPI {
  factory SecurityAPI(Dio dio, AuthService authService) {
    final String baseUrl =
        GlobalConfiguration().getValue('hosts')['security']['host'];
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(HttpOAuthInterceptors());
    dio.interceptors.add(HttpSignatureInterceptors());
    dio.interceptors.add(HttpLanguageInterceptors());
    dio.interceptors.add(HttpErrorInterceptors(dio, authService));
    return _SecurityAPI(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/json'})
  @PUT('/do/api/security/trx/put/settings/v.1')
  Future<BaseResponse> putSettings(@Body() SettingsDto settings);

  @Headers({'content-type': 'application/json'})
  @POST('/do/api/security/trx/post/change-password/v.1')
  Future<BaseResponse> changePassword(@Body() ChangePasswordDto changePassword);
}
