import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/views/auth/forget_password/ui/forget_password_view.dart';
import 'package:mothmerah_app/views/auth/login/data/login_repository.dart';
import 'package:mothmerah_app/views/auth/login/ui/logic/cubit/sign_in_cubit.dart';
import 'package:mothmerah_app/views/auth/login/ui/sign_in_view.dart';
import 'package:mothmerah_app/views/auth/new_password/data/new_password_repository.dart';
import 'package:mothmerah_app/views/auth/new_password/ui/logic/cubit/new_password_cubit.dart';
import 'package:mothmerah_app/views/auth/new_password/ui/new_password_view.dart';
import 'package:mothmerah_app/views/auth/otp/ui/otp_view.dart';
import 'package:mothmerah_app/views/auth/sign_up/data/signup_repository.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_cubit.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/sign_up_view.dart';
import 'package:mothmerah_app/views/profile/data/profile_repository.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_cubit.dart';
import 'package:mothmerah_app/views/profile/ui/profile_view.dart';
import 'package:mothmerah_app/views/splash_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider<LoginRepository>(
            create: (_) => LoginRepository(Dio()),
            child: BlocProvider(
              create: (context) => SignInCubit(context.read<LoginRepository>()),
              child: SignInView(),
            ),
          ),
        );
      case Routes.signupView:
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider<AuthRepository>(
            create: (_) => AuthRepository(Dio()), // or use a preconfigured Dio
            child: BlocProvider(
              create: (context) => SignupCubit(context.read<AuthRepository>()),
              child: SignUpView(),
            ),
          ),
        );

      case Routes.forgetPasswordView:
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      case Routes.otpView:
        return MaterialPageRoute(builder: (_) => OtpView());
      case Routes.newPasswordView:
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider<NewPasswordRepository>(
            create: (_) => NewPasswordRepository(Dio()),
            child: BlocProvider(
              create: (context) =>
                  NewPasswordCubit(context.read<NewPasswordRepository>()),
              child: NewPasswordView(),
            ),
          ),
        );
      case Routes.profileView:
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider<ProfileRepository>(
            create: (_) => ProfileRepository(Dio()),
            child: BlocProvider(
              create: (context) =>
                  ProfileCubit(context.read<ProfileRepository>()),
              child: ProfileView(),
            ),
          ),
        );
      default:
    }

    return null;
  }
}
