// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/assets/img_manager.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, animation, __) {
            return FadeTransition(opacity: animation, child: Scaffold());
          },
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
          child: Hero(tag: "logo", child: Image.asset(ImageManager.logo)),
        ),
      ),
    );
  }
}
