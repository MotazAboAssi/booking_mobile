import 'package:booking/helper/test/print.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  // Strict biometric enforcement (requires device security)
  // static final storage = FlutterSecureStorage(
  //   aOptions: AndroidOptions.biometric(
  //     enforceBiometrics: true, // Requires biometric/PIN/pattern
  //     biometricPromptTitle: 'Authentication Required',
  //   ),
  // );
  final storage = FlutterSecureStorage();

  Future<void> writeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    printGrey("deleting ...");
    await storage.delete(key: key);
    printGrey("Done Delete");
  }

  Future<void> deleteAllData() async {
    await storage.deleteAll();
  }

  Future<bool> isKeyExistence(String key) async {
    return await storage.containsKey(key: key);
  }
}
