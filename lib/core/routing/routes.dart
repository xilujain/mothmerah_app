import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/views/auth/forget_password/ui/forget_password_view.dart';
import 'package:mothmerah_app/views/auth/login/ui/logic/cubit/sign_in_cubit.dart';
import 'package:mothmerah_app/views/auth/login/ui/sign_in_view.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_cubit.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/sign_up_view.dart';
import 'package:mothmerah_app/views/splash_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignInCubit(),
            child: SignInView(),
          ),
        );
      case Routes.signupView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupCubit(),
            child: SignUpView(),
          ),
        );
      case Routes.forgetPasswordView:
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      default:
    }

    return null;
  }
}
