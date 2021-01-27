import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:global_configuration/global_configuration.dart';

class HttpSignatureInterceptors extends InterceptorsWrapper {
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();

  @override
  Future onRequest(RequestOptions options) async {
    final String key = getKey();
    final int timestamp = getTimestamp();
    final String path = options.path;
    final String token = getToken();
    String signature = getSignature('$key:$timestamp:$path:$token');
    options.headers['X-DONGKAP-Key'] = key;
    options.headers['X-DONGKAP-Timestamp'] = timestamp;
    options.headers['X-DONGKAP-Signature'] = signature;
    return options;
  }

  String getKey() {
    return _sharedPreferences.getString('xrkey');
  }

  String getToken() {
    return _sharedPreferences.getString('access_token');
  }

  int getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  String getSignature(String plain) {
    var key = utf8
        .encode(GlobalConfiguration().get('security_resource')['private_key']);
    var bytes = utf8.encode(plain);
    Hmac hmacSha256 = Hmac(sha256, key);
    Digest digest = hmacSha256.convert(bytes);
    return base64.encode(digest.bytes);
  }
}
