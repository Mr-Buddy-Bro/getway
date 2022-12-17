


import 'package:encrypt/encrypt.dart';

class MyEncrypter{
  String encrypt(String text){
    final key = Key.fromUtf8('12345678901234567890123456789012');
    final iv = IV.fromLength(16);
    final encripter = Encrypter(AES(key));
    final en_text = encripter.encrypt(text, iv: iv).base64;
    return en_text;
  }

  String decrypt(String text){
    final key = Key.fromUtf8('12345678901234567890123456789012');
    final iv = IV.fromLength(16);
    final encripter = Encrypter(AES(key));
    final encrypterTxt = Encrypted.from64(text);
    final de_text = encripter.decrypt(encrypterTxt, iv: iv);
    return de_text;
  }
}