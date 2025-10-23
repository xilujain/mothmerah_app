import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/my_app.dart';

bool isLoggedInUser = false;
String initialRoute = Routes.splashView;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkUserAuthStatus();
  runApp(MyApp(appRouter: AppRouter()));
}

checkUserAuthStatus() async {
  bool isLoggedIn = await TokenManager.isLoggedIn();

  if (isLoggedIn) {
    isLoggedInUser = true;
    initialRoute = Routes.profileView; // Navigate to profile if logged in
  } else {
    isLoggedInUser = false;
    initialRoute = Routes.splashView;
  }
}
