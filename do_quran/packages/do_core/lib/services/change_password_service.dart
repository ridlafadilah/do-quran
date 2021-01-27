import 'dart:async';

import 'package:dio/dio.dart';
import 'package:do_core/api/security/security_api.dart';
import 'package:do_core/exceptions/server_error_exception.dart';
import 'package:do_core/models/base_response.dart';
import 'package:do_core/models/change_password_dto.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:do_core/services/encryption_service.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

class ChangePasswordService {
  ChangePasswordService({@required AuthService authService})
      : assert(authService != null),
        _authService = authService;

  final logger = Logger();
  final AuthService _authService;

  Future<BaseResponse> changePassword(
      {String password, String newPassword, String confirmPassword}) async {
    final ChangePasswordDto changePassword = ChangePasswordDto.fromJson({
      'password': EncryptionService.encryptAES(plainText: password),
      'newPassword': EncryptionService.encryptAES(plainText: newPassword),
      'confirmPassword':
          EncryptionService.encryptAES(plainText: confirmPassword),
    });
    final SecurityAPI _securityAPI = SecurityAPI(Dio(), _authService);
    final BaseResponse response = await _securityAPI
        .changePassword(changePassword)
        .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          throw error;
          break;
        default:
      }
    });
    return response;
  }
}
