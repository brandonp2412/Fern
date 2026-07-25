import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage for Akahu credentials, backed by the platform keychain /
/// keystore instead of plaintext SharedPreferences.
class SecureStore {
  static const _storage = FlutterSecureStorage();

  static const _userTokenKey = 'user_token';
  static const _appTokenKey = 'app_token';

  static Future<void> saveCredentials({
    required String userToken,
    required String appToken,
  }) async {
    await Future.wait([
      _storage.write(key: _userTokenKey, value: userToken),
      _storage.write(key: _appTokenKey, value: appToken),
    ]);
  }

  static Future<String?> get userToken => _storage.read(key: _userTokenKey);
  static Future<String?> get appToken => _storage.read(key: _appTokenKey);

  static Future<void> clear() => _storage.deleteAll();
}
