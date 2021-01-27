import 'package:get_it/get_it.dart';

import 'shared_preferences_service.dart';

GetIt coreLocator = GetIt.instance;

Future<void> setupCoreLocator() async {
  SharedPreferencesService sharedPreferencesService =
      await SharedPreferencesService.getInstance();
  coreLocator
      .registerSingleton<SharedPreferencesService>(sharedPreferencesService);
}
