import 'dart:convert';
import 'package:encrypt/encrypt.dart' as e;

class EncryptionService {
   String encrypt(String input) {
    final key = e.Key.fromUtf8(''); // 16-character key
    final iv = e.IV.fromLength(16);

    final encrypter = e.Encrypter(e.AES(key, mode: e.AESMode.cbc));

    final encrypted = encrypter.encrypt(input, iv: iv);

    return encrypted.base64;
  }

  static String decrypt(String encrypted) {
    final key = e.Key.fromUtf8('16CharacterKey123'); // 16-character key
    final iv = e.IV.fromLength(16);

    final encrypter = e.Encrypter(e.AES(key, mode: e.AESMode.cbc));

    final decrypted = encrypter.decrypt(e.Encrypted.fromBase64(encrypted), iv: iv);

    return decrypted;
  }
}

