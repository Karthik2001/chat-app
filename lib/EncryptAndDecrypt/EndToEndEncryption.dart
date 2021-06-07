import 'package:encrypt/encrypt.dart';


class EndToEndEncryption{
  final key = Key.fromUtf8('kkarthiksrinivas');
  final iv = IV.fromLength(8);
  String Encrypt(String plainText, ){

    final encrypter = Encrypter(AES(key));
print(encrypter.encrypt(plainText, iv: iv).base64);
     return encrypter.encrypt(plainText, iv: iv).toString();
  }
  String Decrypt(String encrypted){

    final encrypter = Encrypter(AES(key));
     return encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv).toString();
  }

}