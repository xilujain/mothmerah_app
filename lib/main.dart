import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/helpers/constants.dart';
import 'package:mothmerah_app/core/helpers/shared_pref_helper.dart';
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
  String userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );

  if (userToken.isEmpty) {
    isLoggedInUser = false;
    initialRoute = Routes.splashView;
  } else {
    isLoggedInUser = true;
  }
}
