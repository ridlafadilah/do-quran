import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/api/auth/auth_api.dart';
import 'package:do_core/models/base_response.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:global_configuration/global_configuration.dart';

class HttpErrorInterceptors extends Interceptor {
  HttpErrorInterceptors(this._dio, this._authService);
  final Dio _dio;
  final AuthService _authService;
  final AuthAPI _authAPI = AuthAPI(Dio());
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();
  int refreshCount = 0;

  @override
  Future onResponse(Response response) async {
    refreshCount = 0;
  }

  @override
  Future onError(DioError err) async {
    final int statusCode = err.response.statusCode;
    final BaseResponse response = BaseResponse.fromJson(
        (err.response?.data is List<int>)
            ? json.decode(utf8.decode(err.response?.data))
            : err.response?.data);
    switch (statusCode) {
      case 401:
        try {
          final String msg = response.respStatusMessage['invalid_token'];
          if (msg != null) {
            if (!hasRefreshToken(err.request.headers['authorization']) &&
                refreshCount <= 3) {
              _dio.interceptors.requestLock.lock();
              _dio.interceptors.responseLock.lock();
              await doRefreshToken().catchError((onError) {});
              RequestOptions options = err.response.request;
              if (options.data is FormData) {
                final FormData formData = FormData();
                formData.fields.addAll(options.data.fields);
                for (MapEntry mapFile in options.data.files) {
                  formData.files.add(MapEntry(
                      mapFile.key,
                      MultipartFile.fromFileSync(options.extra['path'],
                          filename: mapFile.value.filename)));
                }
                options.data = formData;
              }
              _dio.interceptors.requestLock.unlock();
              _dio.interceptors.responseLock.unlock();
              return _dio.request(options.path, options: options);
            } else {
              await doLogOut();
            }
          }
        } catch (e) {}
        break;
      default:
        await super.onError(err);
        break;
    }
  }

  Future<void> doRefreshToken() async {
    final String clientId =
        GlobalConfiguration().get('security_resource')['client_id'];
    final String refreshToken = _sharedPreferences.getString('refresh_token');
    Map<String, dynamic> body = {
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'refresh_token': refreshToken,
    };
    await _authService.putSharedPreferences(await _authAPI.token(body));
  }

  Future<void> doLogOut() async {
    refreshCount = 0;
    await _authService.logOut();
  }

  bool hasRefreshToken(String authorization) {
    refreshCount++;
    authorization = authorization.replaceAll('Bearer ', '');
    final String accessToken = _sharedPreferences.getString('access_token');
    return authorization != accessToken;
  }
}
