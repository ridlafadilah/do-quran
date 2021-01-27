import 'package:logger/logger.dart';

class TwoFactorAuthenticationService {
  final logger = Logger();
  final bool is2FA = false;

  bool getData() {
    return is2FA;
  }

  Future<bool> putData(bool data) async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    return data;
  }
}
