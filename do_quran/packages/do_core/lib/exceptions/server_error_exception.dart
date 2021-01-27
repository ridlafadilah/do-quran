import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/models/base_response.dart';

class ServerError implements Exception {
  ServerError({String error}) {
    _errorMessage = error;
  }

  ServerError.withError({DioError error}) {
    _handleError(error);
  }

  int _errorCode;
  String _errorMessage = '';
  BaseResponse _errorResponse;

  int getErrorCode() {
    return _errorCode;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  BaseResponse getErrorResponse() {
    return _errorResponse;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = 'errorDioCancel';
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = 'errorDioConnectTimeout';
        break;
      case DioErrorType.DEFAULT:
        _errorMessage = 'errorDioDefault';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = 'errorDioReceiveTimeout';
        break;
      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = 'errorDioSendTimeout';
        break;
      case DioErrorType.RESPONSE:
        BaseResponse _errorResponse = BaseResponse.fromJson(
            (error.response.data is List<int>)
                ? json.decode(utf8.decode(error.response.data))
                : error.response.data);
        if (_errorResponse.respStatusCode != null) {
          _errorMessage =
              _errorResponse.respStatusMessage[_errorResponse.respStatusCode];
          if (_errorResponse.respStatusMessage['invalid_token'] != null) {
            _errorMessage = 'ERR_401';
          }
        } else {
          _errorMessage = 'ERR_${error.response.statusCode}';
        }
        break;
    }
    return _errorMessage;
  }

  @override
  String toString() {
    return _errorMessage;
  }
}
