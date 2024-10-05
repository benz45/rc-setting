import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncrypterBusiness {
  final key = Key.fromUtf8(dotenv.env['ENCRYPT_SECRET']!);
  final iv = IV.fromUtf8(dotenv.env['ENCRYPT_IV']!);

  String encrypt(String data) {
    Encrypter encrypter = Encrypter(AES(key));
    Encrypted encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String base64String) {
    Encrypter encrypter = Encrypter(AES(key));
    return encrypter.decrypt(Encrypted.fromBase64(base64String), iv: iv);
  }
}
