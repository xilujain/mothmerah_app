import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/core/helpers/token_validator.dart';
import 'package:mothmerah_app/core/routing/routes.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  /// Check if user is authenticated and handle token expiration
  static Future<bool> isAuthenticated() async {
    return await TokenManager.isLoggedIn();
  }

  /// Handle automatic logout with navigation
  static Future<void> handleLogout(
    BuildContext context, {
    String? reason,
  }) async {
    try {
      // Clear all user data
      await TokenManager.clearUserData();

      // Show logout message if reason provided
      if (reason != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(reason),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      // Navigate to login screen
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginView,
          (route) => false,
        );
      }
    } catch (e) {
      // Log error for debugging but don't show to user
      // The navigation should still work even if there's an error
    }
  }

  /// Handle token expiration automatically
  static Future<void> handleTokenExpiration(BuildContext context) async {
    await handleLogout(
      context,
      reason: 'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى',
    );
  }

  /// Check API response and handle token expiration
  static Future<bool> checkApiResponse(
    BuildContext context,
    Map<String, dynamic> response,
  ) async {
    final wasExpired = await TokenManager.handleApiResponse(response);

    if (wasExpired && context.mounted) {
      await handleTokenExpiration(context);
    }

    return wasExpired;
  }

  /// Check if token needs refresh
  static Future<bool> needsTokenRefresh() async {
    return await TokenManager.needsTokenRefresh();
  }

  /// Get token information for debugging
  static Future<Map<String, dynamic>?> getTokenInfo() async {
    return await TokenManager.getTokenInfo();
  }

  /// Validate token before making API calls
  static Future<bool> validateTokenBeforeApiCall() async {
    final token = await TokenManager.getToken();
    if (token.isEmpty) return false;

    if (TokenValidator.isTokenExpired(token)) {
      await TokenManager.handleTokenExpiration();
      return false;
    }

    return true;
  }

  /// Periodic token validation (call this in app lifecycle)
  static Future<void> validateTokenPeriodically(BuildContext context) async {
    if (!await isAuthenticated()) {
      if (context.mounted) {
        await handleLogout(context, reason: 'انتهت صلاحية الجلسة');
      }
      return;
    }

    // Check if token needs refresh
    if (await needsTokenRefresh()) {
      // In a real app, you would refresh the token here
      // For now, we'll just show a warning
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ستنتهي صلاحية الجلسة قريباً'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  /// Handle DioException for authentication errors
  static Future<bool> handleDioException(
    BuildContext context,
    dynamic error,
  ) async {
    try {
      // Check if it's a 401 or 403 error
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 403) {
        await handleTokenExpiration(context);
        return true;
      }

      // Check response data for token expiration indicators
      if (error.response?.data != null) {
        final responseData = error.response!.data;
        if (responseData is Map<String, dynamic>) {
          return await checkApiResponse(context, responseData);
        }
      }
    } catch (e) {
      // Log error for debugging but don't show to user
      // Return false to indicate no token expiration was detected
    }

    return false;
  }

  /// Logout user manually
  static Future<void> logout(BuildContext context) async {
    await handleLogout(context, reason: 'تم تسجيل الخروج بنجاح');
  }

  /// Force logout (for debugging)
  static Future<void> forceLogout(BuildContext context) async {
    await TokenManager.forceClearAllData();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginView,
        (route) => false,
      );
    }
  }
}
