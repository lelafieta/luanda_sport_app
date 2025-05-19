abstract class ISecureStorageHelper {
  Future<String?> getData(String key);
  Future<void> saveDate(String key, String value);
  Future<void> removeData(String key);
  Future<void> clearAllData();
}
