import 'package:encrypt/encrypt.dart';

class EncryptHelper {
  static const IV_LENGTH = 16; // For AES, this is always 16
  static const IV_DEFAULT = "fbc98020947ddd569cbfb7a301483d97";
  static const ENCRYPTION_KEY = 'asdcsdfewqasdfgrasdcsdfewqasdfgr';

  static String encrypt(String text, bool isRandom) {
    print('text: $text');
    var iv =
        isRandom ? IV.fromSecureRandom(IV_LENGTH) : IV.fromBase16(IV_DEFAULT);
    final key = Key.fromUtf8(ENCRYPTION_KEY);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);

    return "${iv.base16}:${encrypted.base16}";
  }

  static String decrypt(String ciphertext) {
    try {
      if (ciphertext.isEmpty) return '';
      var textParts = ciphertext.split(':');

      final iv = IV.fromBase16(textParts[0]);
      final key = Key.fromUtf8(ENCRYPTION_KEY);

      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted =
          encrypter.decrypt(Encrypted.fromBase16(textParts[1]), iv: iv);

      return decrypted;
    } catch (err) {
      return ciphertext;
    }
  }
}
