import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'configs/security_config.dart';
import 'dongkap_app.dart';
import 'environments/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupConfiguration(Environment(), SecurityConfig());
  await setupLocator();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(const DongkapApp()));
}
