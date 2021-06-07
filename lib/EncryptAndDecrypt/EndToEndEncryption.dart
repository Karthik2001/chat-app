import 'package:encrypt/encrypt.dart';


class EndToEndEncryption{
  final key = Key.fromUtf8('kkarthiksrinivas');
  final iv = IV.fromLength(8);
  String Encrypt(String plainText ){

    final encrypter = Encrypter(AES(key));

     return encrypter.encrypt(plainText, iv: iv).base64;
  }
  String Decrypt(String encrypted){

    final encrypter = Encrypter(AES(key));
     return encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv).toString();
  }

}