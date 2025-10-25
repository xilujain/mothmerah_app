import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/services/auth_service.dart';

class AppLifecycleService extends WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  factory AppLifecycleService() => _instance;
  AppLifecycleService._internal();

  BuildContext? _context;
  bool _isInitialized = false;

  /// Initialize the service with context
  void initialize(BuildContext context) {
    if (!_isInitialized) {
      _context = context;
      WidgetsBinding.instance.addObserver(this);
      _isInitialized = true;

      // Check token validity on app start
      _checkTokenValidity();
    }
  }

  /// Dispose the service
  void dispose() {
    if (_isInitialized) {
      WidgetsBinding.instance.removeObserver(this);
      _isInitialized = false;
      _context = null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App came to foreground, check token validity
        _checkTokenValidity();
        break;
      case AppLifecycleState.paused:
        // App went to background
        break;
      case AppLifecycleState.inactive:
        // App is inactive
        break;
      case AppLifecycleState.detached:
        // App is detached
        break;
      case AppLifecycleState.hidden:
        // App is hidden
        break;
    }
  }

  /// Check token validity and handle expiration
  Future<void> _checkTokenValidity() async {
    if (_context == null || !_context!.mounted) return;

    try {
      // Check if user is authenticated
      if (!await AuthService.isAuthenticated()) {
        if (_context!.mounted) {
          await AuthService.handleLogout(
            _context!,
            reason: 'انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى',
          );
        }
        return;
      }

      // Check if token needs refresh
      if (await AuthService.needsTokenRefresh()) {
        if (_context!.mounted) {
          await AuthService.validateTokenPeriodically(_context!);
        }
      }
    } catch (e) {
      // Log error for debugging but don't show to user
      // Token validation should continue even if there's an error
    }
  }

  /// Manually trigger token validation
  Future<void> validateToken() async {
    await _checkTokenValidity();
  }

  /// Get token information for debugging
  Future<Map<String, dynamic>?> getTokenInfo() async {
    return await AuthService.getTokenInfo();
  }
}
