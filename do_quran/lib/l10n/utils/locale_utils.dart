import 'package:intl/intl.dart';

class LocaleUtils {
  static String translate(String message) {
    return Intl.message(
      message,
      name: message,
      desc: '',
      args: [],
    );
  }
}
