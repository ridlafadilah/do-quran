import 'package:dio/dio.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';

class HttpOAuthInterceptors extends InterceptorsWrapper {
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();

  @override
  Future onRequest(RequestOptions options) async {
    final String authorization = _sharedPreferences.getString('access_token');
    assert(authorization != null);
    options.headers['authorization'] = 'Bearer $authorization';
    return options;
  }
}
