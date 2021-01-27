import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';

class ProviderService {
  final logger = Logger();
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();

  String getData() {
    return _sharedPreferences.getString('provider');
  }
}
