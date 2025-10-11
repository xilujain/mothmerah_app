import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/views/auth/forget_password/ui/forget_password_view.dart';
import 'package:mothmerah_app/views/auth/login/ui/sign_in_view.dart';
import 'package:mothmerah_app/views/splash_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => SignInView());
        case Routes.forgetPasswordView:
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      default:
    }

    return null;
  }
}
