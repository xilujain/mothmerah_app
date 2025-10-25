import 'package:jwt_decoder/jwt_decoder.dart';

class TokenValidator {
  /// Check if JWT token is expired
  static bool isTokenExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      // If token is invalid or can't be decoded, consider it expired
      return true;
    }
  }

  /// Get token expiration date
  static DateTime? getTokenExpirationDate(String token) {
    try {
      return JwtDecoder.getExpirationDate(token);
    } catch (e) {
      return null;
    }
  }

  /// Get time until token expires
  static Duration? getTimeUntilExpiration(String token) {
    try {
      final expirationDate = JwtDecoder.getExpirationDate(token);
      return expirationDate.difference(DateTime.now());
    } catch (e) {
      return null;
    }
  }

  /// Check if token will expire within specified duration
  static bool willExpireWithin(String token, Duration duration) {
    try {
      final timeUntilExpiration = getTimeUntilExpiration(token);
      if (timeUntilExpiration != null) {
        return timeUntilExpiration <= duration;
      }
      return true; // If we can't determine, assume it's expired
    } catch (e) {
      return true;
    }
  }

  /// Extract user ID from token
  static String? getUserIdFromToken(String token) {
    try {
      final payload = JwtDecoder.decode(token);
      return payload['user_id']?.toString() ?? payload['sub']?.toString();
    } catch (e) {
      return null;
    }
  }

  /// Extract username from token
  static String? getUsernameFromToken(String token) {
    try {
      final payload = JwtDecoder.decode(token);
      return payload['username']?.toString() ??
          payload['preferred_username']?.toString();
    } catch (e) {
      return null;
    }
  }

  /// Extract phone number from token
  static String? getPhoneFromToken(String token) {
    try {
      final payload = JwtDecoder.decode(token);
      return payload['phone_number']?.toString();
    } catch (e) {
      return null;
    }
  }

  /// Check if token is valid (not expired and has required fields)
  static bool isTokenValid(String token) {
    if (token.isEmpty) return false;

    try {
      // Check if token is expired
      if (isTokenExpired(token)) return false;

      // Check if token has required fields
      final payload = JwtDecoder.decode(token);
      return payload.containsKey('user_id') || payload.containsKey('sub');
    } catch (e) {
      return false;
    }
  }

  /// Get token payload as Map
  static Map<String, dynamic>? getTokenPayload(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      return null;
    }
  }

  /// Check if API response indicates token expiration
  static bool isTokenExpiredResponse(Map<String, dynamic> response) {
    // Check for common token expiration indicators
    final message = response['message']?.toString().toLowerCase() ?? '';
    final detail = response['detail']?.toString().toLowerCase() ?? '';
    final error = response['error']?.toString().toLowerCase() ?? '';

    return message.contains('token') &&
            (message.contains('expired') || message.contains('invalid')) ||
        detail.contains('token') &&
            (detail.contains('expired') || detail.contains('invalid')) ||
        error.contains('token') &&
            (error.contains('expired') || error.contains('invalid')) ||
        response['status_code'] == 401 ||
        response['status_code'] == 403;
  }

  /// Check if API response indicates authentication failure
  static bool isAuthenticationError(Map<String, dynamic> response) {
    final statusCode = response['status_code'] ?? response['statusCode'] ?? 0;
    return statusCode == 401 || statusCode == 403;
  }
}
