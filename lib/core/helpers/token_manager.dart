import 'package:mothmerah_app/core/helpers/constants.dart';
import 'package:mothmerah_app/core/helpers/shared_pref_helper.dart';
import 'package:mothmerah_app/core/helpers/token_validator.dart';

class TokenManager {
  static const String _tokenKey = SharedPrefKeys.userToken;
  static const String _userDataKey = 'userData';
  static const String _tokenExpiryKey = 'tokenExpiry';

  /// Save user token and data
  static Future<void> saveUserData({
    required String token,
    required Map<String, dynamic> userData,
    DateTime? expiryDate,
  }) async {
    await SharedPrefHelper.setSecuredString(_tokenKey, token);
    await SharedPrefHelper.setData(_userDataKey, userData);

    if (expiryDate != null) {
      await SharedPrefHelper.setData(
        _tokenExpiryKey,
        expiryDate.millisecondsSinceEpoch,
      );
    }
  }

  /// Get stored token
  static Future<String> getToken() async {
    return await SharedPrefHelper.getSecuredString(_tokenKey);
  }

  /// Get stored user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final userData = await SharedPrefHelper.getData(_userDataKey);
    return userData as Map<String, dynamic>?;
  }

  /// Check if user is logged in and token is valid
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    if (token.isEmpty) return false;

    // Use TokenValidator to check if token is valid
    if (!TokenValidator.isTokenValid(token)) {
      // Token is invalid or expired, clear data
      await clearUserData();
      return false;
    }

    // Additional check for stored expiry date (backup)
    final expiryTimestamp = await SharedPrefHelper.getInt(_tokenExpiryKey);
    if (expiryTimestamp > 0) {
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
      if (DateTime.now().isAfter(expiryDate)) {
        // Token expired, clear data
        await clearUserData();
        return false;
      }
    }

    return true;
  }

  /// Clear all user data and token
  static Future<void> clearUserData() async {
    await SharedPrefHelper.removeSecuredData(_tokenKey);
    await SharedPrefHelper.removeData(_userDataKey);
    await SharedPrefHelper.removeData(_tokenExpiryKey);
  }

  /// Update user data without changing token
  static Future<void> updateUserData(Map<String, dynamic> userData) async {
    await SharedPrefHelper.setData(_userDataKey, userData);
  }

  /// Check if token is expired
  static Future<bool> isTokenExpired() async {
    final expiryTimestamp = await SharedPrefHelper.getInt(_tokenExpiryKey);
    if (expiryTimestamp <= 0) return false; // No expiry set

    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
    return DateTime.now().isAfter(expiryDate);
  }

  /// Force clear all data (for debugging)
  static Future<void> forceClearAllData() async {
    try {
      await SharedPrefHelper.removeSecuredData(_tokenKey);
      await SharedPrefHelper.removeData(_userDataKey);
      await SharedPrefHelper.removeData(_tokenExpiryKey);
    } catch (e) {
      // Log error for debugging but don't show to user
      // Data clearing should continue even if some operations fail
    }
  }

  /// Check if token will expire soon and needs refresh
  static Future<bool> needsTokenRefresh({
    Duration threshold = const Duration(minutes: 5),
  }) async {
    final token = await getToken();
    if (token.isEmpty) return false;

    return TokenValidator.willExpireWithin(token, threshold);
  }

  /// Get token expiration info
  static Future<Map<String, dynamic>?> getTokenInfo() async {
    final token = await getToken();
    if (token.isEmpty) return null;

    try {
      final payload = TokenValidator.getTokenPayload(token);
      final expirationDate = TokenValidator.getTokenExpirationDate(token);
      final timeUntilExpiration = TokenValidator.getTimeUntilExpiration(token);

      return {
        'payload': payload,
        'expirationDate': expirationDate,
        'timeUntilExpiration': timeUntilExpiration,
        'isExpired': TokenValidator.isTokenExpired(token),
        'isValid': TokenValidator.isTokenValid(token),
      };
    } catch (e) {
      return null;
    }
  }

  /// Handle automatic logout when token expires
  static Future<void> handleTokenExpiration() async {
    await clearUserData();
  }

  /// Check if API response indicates token expiration and handle it
  static Future<bool> handleApiResponse(Map<String, dynamic> response) async {
    if (TokenValidator.isTokenExpiredResponse(response) ||
        TokenValidator.isAuthenticationError(response)) {
      await handleTokenExpiration();
      return true; // Token was expired/invalid
    }
    return false; // Token is still valid
  }
}
