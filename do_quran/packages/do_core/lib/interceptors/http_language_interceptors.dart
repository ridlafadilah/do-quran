import 'package:dio/dio.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';

class HttpLanguageInterceptors extends InterceptorsWrapper {
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();

  @override
  Future onRequest(RequestOptions options) async {
    options.headers['accept-language'] = _sharedPreferences.getString('locale');
    return options;
  }
}
