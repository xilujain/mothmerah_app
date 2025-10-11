import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/my_app.dart';

bool isLoggedInUser = false;
String initialRoute = Routes.splashView;

void main() async {
  runApp(MyApp(appRouter: AppRouter()));
}
