import 'package:intl/intl.dart';

class DatetimeUtils {
  static String getTime(var format) {
    var date = DateTime.now();
    var f = DateFormat(format);
    return f.format(date);
  }

  static int timeToInt(String time) {
    List<String> listData = time.split(':');
    return (int.parse(listData[0]) * 60) + int.parse(listData[1]);
  }
}
