import 'dart:async';

import 'package:dio/dio.dart';
import 'package:do_core/api/security/security_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models/settings_dto.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';

class ThemeType {
  static const defaultTheme = 'default';
  static const darkTheme = 'dark';
}

class ThemeService {
  ThemeService({AuthService authService}) : _authService = authService;

  final logger = Logger();
  final AuthService _authService;
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();

  bool getData() {
    final String theme = _sharedPreferences.getString('theme');
    switch (theme) {
      case ThemeType.darkTheme:
        return true;
        break;
      default:
        return false;
    }
  }

  Future<bool> putData(bool data) async {
    final String localeCode = _sharedPreferences.getString('locale');
    SettingsDto settings;
    if (data) {
      settings = SettingsDto.fromJson({
        'theme': ThemeType.darkTheme,
        'localeCode': localeCode,
      });
    } else {
      settings = SettingsDto.fromJson({
        'theme': ThemeType.defaultTheme,
        'localeCode': localeCode,
      });
    }
    final SecurityAPI _securityAPI = SecurityAPI(Dio(), _authService);
    await _securityAPI.putSettings(settings).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
    await _sharedPreferences.putString('theme', settings.theme);
    return data;
  }

  Future<bool> putDataSharedPreferences(bool data) async {
    final String localeCode = _sharedPreferences.getString('locale');
    SettingsDto settings;
    if (data) {
      settings = SettingsDto.fromJson({
        'theme': ThemeType.darkTheme,
        'localeCode': localeCode,
      });
    } else {
      settings = SettingsDto.fromJson({
        'theme': ThemeType.defaultTheme,
        'localeCode': localeCode,
      });
    }
    await _sharedPreferences.putString('theme', settings.theme);
    return data;
  }
}
