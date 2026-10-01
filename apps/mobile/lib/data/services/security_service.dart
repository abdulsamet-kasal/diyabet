import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class SecurityService {
  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;

  static const _biometricEnabledKey = 'gliko_biometric_lock_enabled';
  static const _authTokenKey = 'gliko_auth_token';

  SecurityService({
    LocalAuthentication? localAuth,
    FlutterSecureStorage? secureStorage,
  })  : _localAuth = localAuth ?? LocalAuthentication(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<bool> canCheckBiometrics() async {
    try {
      final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> authenticate({String reason = 'Glikoz ve insülin sağlık verilerinizi korumak için doğrulama yapın'}) async {
    try {
      final isAvailable = await canCheckBiometrics();
      if (!isAvailable) return true; // If device does not support, do not block

      return await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: false,
      );
    } on PlatformException {
      return false;
    }
  }

  Future<bool> isBiometricLockEnabled() async {
    final val = await _secureStorage.read(key: _biometricEnabledKey);
    return val == 'true';
  }

  Future<void> setBiometricLockEnabled(bool enabled) async {
    await _secureStorage.write(key: _biometricEnabledKey, value: enabled ? 'true' : 'false');
  }

  Future<void> saveAuthToken(String token) async {
    await _secureStorage.write(key: _authTokenKey, value: token);
  }

  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: _authTokenKey);
  }

  Future<void> clearAllSecureData() async {
    await _secureStorage.deleteAll();
  }
}
