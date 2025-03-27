import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Encryptor {
  // Create a secure storage instance
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  //static const String _keyString = 'my32lengthsupersecretnooneknows1';
  final encrypt.Key _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final encrypt.IV _iv = encrypt.IV.fromLength(16); // Initialization Vector (static)

final encrypt.Encrypter _encrypter = encrypt.Encrypter(encrypt.AES(
    encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'),
    mode: encrypt.AESMode.cbc, // Ensure AES mode consistency
  ));

// Encrypt Data
  String _encryptData(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  // Decrypt Data
  String _decryptData(String encryptedText) {
    try {
      return _encrypter.decrypt64(encryptedText, iv: _iv);
    } catch (e) {
      print("Decryption failed: $e");
      return "Invalid data or corrupted storage.";
    }
  }

  // Save Data to Storage
  Future<void> saveData(String key, String value) async {
    final encryptedValue = _encryptData(value);
    print("Encryption: $key:  $encryptedValue");
    await _secureStorage.write(key: key, value: encryptedValue);
  }

  // Retrieve Data from Storage
  Future<String?> getData(String key) async {
    final encryptedValue = await _secureStorage.read(key: key);
    if (encryptedValue != null) {
      return _decryptData(encryptedValue);
    }
    return null;
  }
}