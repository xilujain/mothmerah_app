import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/views/splash_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => SplashView());
      default:
    }

    return null;
  }
}
