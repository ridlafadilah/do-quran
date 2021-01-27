import 'dart:async';

import 'package:dio/dio.dart';
import 'package:do_core/api/security/security_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models/base_response.dart';
import 'package:do_core/models/locale_dto.dart';
import 'package:do_core/models/settings_dto.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';

class LanguageService {
  LanguageService({AuthService authService}) : _authService = authService;

  final logger = Logger();
  final AuthService _authService;
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();
  final List<LocaleDto> locales = <LocaleDto>[
    LocaleDto.fromJson({
      'localeCode': 'en-US',
      'identifier': 'English',
      'subIdentifier': 'United States',
      'icon': 'flag-icon flag-icon-us',
      'localeUsed': false,
      'localeDefault': true,
      'localeEnabled': true,
    }),
    LocaleDto.fromJson({
      'localeCode': 'id-ID',
      'identifier': 'Indonesian',
      'subIdentifier': 'Indonesia',
      'icon': 'flag-icon flag-icon-id',
      'localeUsed': false,
      'localeDefault': false,
      'localeEnabled': true,
    }),
  ];

  LocaleDto getCurrentLocale() {
    final String localeCode = _sharedPreferences.getString('locale') == null
        ? 'en-US'
        : _sharedPreferences.getString('locale');
    return locales.singleWhere((element) => element.localeCode == localeCode);
  }

  List<LocaleDto> getData() {
    final String localeCode = _sharedPreferences.getString('locale');
    LocaleDto locale =
        locales.singleWhere((element) => element.localeCode == localeCode);
    final int index =
        locales.indexWhere((element) => element.localeCode == localeCode);
    locale.localeUsed = true;
    locales.replaceRange(index, index + 1, [locale]);
    return locales;
  }

  Future<BaseResponse> putData(LocaleDto data) async {
    final String theme = _sharedPreferences.getString('theme');
    final _settingsAPI = SecurityAPI(Dio(), _authService);
    final SettingsDto settings = SettingsDto.fromJson({
      'localeCode': data.localeCode,
      'localeIdentifier': data.identifier,
      'localeIcon': data.icon,
      'theme': theme,
    });
    final BaseResponse response =
        await _settingsAPI.putSettings(settings).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
    await _sharedPreferences.putString('locale', data.localeCode);
    return response;
  }
}
