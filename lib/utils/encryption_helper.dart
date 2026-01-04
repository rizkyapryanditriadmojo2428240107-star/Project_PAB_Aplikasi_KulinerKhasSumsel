import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final _key = encrypt.Key.fromUtf8(
    '12345678901234567890123456789012',
  );

  static final _iv = encrypt.IV.fromUtf8(
    '1234567890123456',
  );

  static final _encrypter = encrypt.Encrypter(
    encrypt.AES(_key, mode: encrypt.AESMode.cbc),
  );

  static String encryptText(String plain) {
    final encrypted = _encrypter.encrypt(plain, iv: _iv);
    return encrypted.base64;
  }

  static String decryptText(String encryptedBase64) {
    final decrypted = _encrypter.decrypt64(encryptedBase64, iv: _iv);
    return decrypted;
  }
}