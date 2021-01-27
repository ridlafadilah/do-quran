import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:do_core/api/auth/auth_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/encryption_service.dart';
import 'package:do_core/services/google_service.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

class AuthService {
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();
  final logger = Logger();
  final _controller = StreamController<AuthStatus>();
  final GoogleService _googleSignIn = GoogleService();
  AuthAPI _authAPI;

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (_sharedPreferences.isKeyExists('access_token')) {
      yield AuthStatus.authenticated;
    } else {
      yield AuthStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<String> requestForgotPassword({
    @required String email,
  }) async {
    Map<String, dynamic> body = {'email': email, 'pin': true};
    _authAPI = AuthAPI(Dio());
    BaseResponse response =
        await _authAPI.requestForgotPassword(body).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
    return response.respStatusMessage[response.respStatusCode];
  }

  Future<void> verificationForgotPassword({
    @required String verificationId,
    @required String verificationCode,
  }) async {
    Map<String, dynamic> body = {
      'verificationId': verificationId,
      'verificationCode': verificationCode
    };
    _authAPI = AuthAPI(Dio());
    await _authAPI.verificationForgotPassword(body).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
  }

  Future<void> forgotPassword({
    @required String verificationId,
    @required String verificationCode,
    @required String newPassword,
    @required String confirmPassword,
  }) async {
    Map<String, dynamic> body = {
      'verificationId': verificationId,
      'verificationCode': verificationCode,
      'newPassword': EncryptionService.encryptAES(plainText: newPassword),
      'confirmPassword':
          EncryptionService.encryptAES(plainText: confirmPassword)
    };
    _authAPI = AuthAPI(Dio());
    await _authAPI.forgotPassword(body).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
  }

  Future<void> signup({
    @required String fullname,
    @required String username,
    @required String email,
    @required String password,
    @required String confirmPassword,
    @required String terms,
    @required String recaptcha,
  }) async {
    Map<String, dynamic> body = {
      'fullname': fullname,
      'username': username,
      'email': email,
      'password': EncryptionService.encryptAES(plainText: password),
      'confirmPassword':
          EncryptionService.encryptAES(plainText: confirmPassword),
      'terms': terms,
      'recaptcha': recaptcha
    };
    _authAPI = AuthAPI(Dio());
    await _authAPI.signup(body).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    final String clientId =
        GlobalConfiguration().get('security_resource')['client_id'].toString();
    Map<String, dynamic> body = {
      'grant_type': 'password',
      'client_id': clientId,
      'username': username,
      'password': password
    };
    _authAPI = AuthAPI(Dio());
    await _authAPI.token(body).then((value) async {
      await putSharedPreferences(value)
          .then((value) => _controller.add(AuthStatus.authenticated));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
  }

  Future<bool> loginGoogle() async {
    final String clientId =
        GlobalConfiguration().get('google')['client_id'].toString();
    try {
      String token;
      try {
        token = await _googleSignIn.loginGoogle(clientId);
      } catch (e) {
        return false;
      }
      Map<String, dynamic> body = {
        'token': token,
        'provider': GoogleService.provider,
        'client_id': clientId
      };
      _authAPI = AuthAPI(Dio());
      await _authAPI.tokenVerifier(body).then((value) async {
        await putSharedPreferences(value)
            .then((value) => _controller.add(AuthStatus.authenticated));
      });
      return true;
    } catch (e) {
      _googleSignIn.logoutGoogle(clientId);
      throw ServerError(error: 'ERR_500');
    }
  }

  OAuthResult getOAuthResult() {
    return OAuthResult.fromJson({
      'access_token': _sharedPreferences.getString('access_token'),
      'refresh_token': _sharedPreferences.getString('refresh_token'),
      'token_type': _sharedPreferences.getString('token_type'),
      'xrkey': _sharedPreferences.getString('xrkey'),
      'expires_in': _sharedPreferences.getInt('expires_in'),
      'authority': _sharedPreferences.getString('authority'),
      'provider': _sharedPreferences.getString('provider'),
      'image': _sharedPreferences.getString('image'),
      'email': _sharedPreferences.getString('email'),
      'menus': _sharedPreferences.getString('menus'),
      'extras': _sharedPreferences.getString('extras'),
      'server_date': _sharedPreferences.getString('server_date'),
      'locale': _sharedPreferences.getString('locale'),
      'theme': _sharedPreferences.getString('theme'),
      'name': _sharedPreferences.getString('name'),
      'username': _sharedPreferences.getString('username'),
    });
  }

  Future<void> logOut() async {
    if (_sharedPreferences.getString('provider') != 'local') {
      final String clientId =
          GlobalConfiguration().get('google')['client_id'].toString();
      _googleSignIn.logoutGoogle(clientId);
    }
    await _sharedPreferences.clearKey('username');
    await _sharedPreferences.clearKey('access_token');
    await _sharedPreferences.clearKey('refresh_token');
    await _sharedPreferences.clearKey('token_type');
    await _sharedPreferences.clearKey('expires_in');
    await _sharedPreferences.clearKey('authority');
    await _sharedPreferences.clearKey('provider');
    await _sharedPreferences.clearKey('server_date');
    _controller.add(AuthStatus.unauthenticated);
  }

  Future<void> putSharedPreferences(OAuthResult value) async {
    await _sharedPreferences.putString('access_token', value.accessToken);
    await _sharedPreferences.putString('refresh_token', value.refreshToken);
    await _sharedPreferences.putString('token_type', value.tokenType);
    await _sharedPreferences.putString('xrkey', value.publicKey);
    await _sharedPreferences.putInt('expires_in', value.expiresIn);
    await _sharedPreferences.putString('authority', value.authority);
    await _sharedPreferences.putString('provider', value.provider);
    await _sharedPreferences.putString('image', value.image);
    await _sharedPreferences.putString('email', value.email);
    await _sharedPreferences.putString('menus', json.encode(value.menus));
    await _sharedPreferences.putString('extras', json.encode(value.extras));
    await _sharedPreferences.putString('server_date', value.serverDate);
    await _sharedPreferences.putString('locale', value.locale);
    await _sharedPreferences.putString('theme', value.theme);
    await _sharedPreferences.putString('name', value.name);
    await _sharedPreferences.putString('username', value.username);
  }

  void dispose() => _controller.close();
}
