


import 'package:encrypt/encrypt.dart';

class MyEncrypter{
  String encrypt(String text){
    final key = Key.fromUtf8('12345678901234567890123456789012');
    final iv = IV.fromLength(16);
    final encripter = Encrypter(AES(key));
    final en_text = encripter.encrypt(text, iv: iv).base64;
    return en_text;
  }

  String decrypt(Encrypted text){
    final key = Key.fromUtf8('12345678901234567890123456789012');
    final iv = IV.fromLength(16);
    final encripter = Encrypter(AES(key));
    final de_text = encripter.decrypt(text, iv: iv);
    return de_text;
  }
}