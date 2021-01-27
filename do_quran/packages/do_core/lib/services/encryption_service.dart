import 'package:encrypt/encrypt.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:convert/convert.dart';
import 'package:meta/meta.dart';

class EncryptionService {
  static String encryptAES({
    @required String plainText,
  }) {
    final String secretKey =
        GlobalConfiguration().get('security_resource')['aes_key'].toString();
    final key = Key.fromUtf8(secretKey);
    final int ivSize = 128;
    final IV iv = IV.fromSecureRandom(ivSize ~/ 8);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
    return hex.encode(iv.bytes) + encrypted.base64.toString();
  }
}
