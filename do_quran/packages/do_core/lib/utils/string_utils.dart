class StringUtils {
  static String toCamelCase(String str) {
    String s = str
        .replaceAllMapped(
            RegExp(
                r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
            (Match m) =>
                '${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}')
        .replaceAll(RegExp(r'(_|-|\s)+'), '');
    return s[0].toLowerCase() + s.substring(1);
  }

  static String toFarsi(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }
    return input;
  }
}
