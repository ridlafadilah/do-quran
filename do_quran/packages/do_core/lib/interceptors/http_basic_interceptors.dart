import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';

class HttpBasicInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final String clientId =
        GlobalConfiguration().get('security_resource')['client_id'];
    final String clientSecret =
        GlobalConfiguration().get('security_resource')['client_secret'];
    final String authorization =
        base64Encode(utf8.encode('$clientId:$clientSecret'));
    assert(clientId != null);
    assert(clientSecret != null);
    options.headers['authorization'] = 'Basic $authorization';
    return options;
  }
}
