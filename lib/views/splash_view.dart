// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/assets/img_manager.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/views/auth/login/data/login_repository.dart';
import 'package:mothmerah_app/views/auth/login/ui/logic/cubit/sign_in_cubit.dart';
import 'package:mothmerah_app/views/auth/login/ui/sign_in_view.dart';
import 'package:dio/dio.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      // Check if user is already logged in
      final isLoggedIn = await TokenManager.isLoggedIn();
      
      if (isLoggedIn) {
        // User is logged in, navigate to home
        Navigator.of(context).pushReplacementNamed(Routes.homeView);
      } else {
        // User is not logged in, navigate to login
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (_, animation, __) {
              return FadeTransition(
                opacity: animation,
                child: RepositoryProvider<LoginRepository>(
                  create: (_) => LoginRepository(Dio()),
                  child: BlocProvider(
                    create: (context) =>
                        SignInCubit(context.read<LoginRepository>()),
                    child: SignInView(),
                  ),
                ),
              );
            },
          ),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(60.w),
          child: Hero(
            tag: "logo",
            child: Image.asset(ImageManager.logo, width: 200.w, height: 200.h),
          ),
        ),
      ),
    );
  }
}
