import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'i_secure_storage_helper.dart';

class SecureStorageHelper implements ISecureStorageHelper {
  final FlutterSecureStorage secureStorage;

  SecureStorageHelper({required this.secureStorage});

  @override
  Future<void> clearAllData() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<String?> getData(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> removeData(String key) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<void> saveDate(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
}
