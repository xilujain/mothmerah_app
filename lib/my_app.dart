import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/services/app_lifecycle_service.dart';
import 'package:mothmerah_app/main.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_cubit.dart';
import 'package:mothmerah_app/views/order/data/order_repository.dart';
import 'package:mothmerah_app/views/order/ui/logic/cubit/order_cubit.dart';
import 'package:dio/dio.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize app lifecycle service after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppLifecycleService().initialize(context);
    });
  }

  @override
  void dispose() {
    AppLifecycleService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => OrderCubit(OrderRepository(Dio()))),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale("ar", "AE")],
          locale: const Locale("ar", "AE"),
          onGenerateRoute: AppRouter().generateRoute,
          initialRoute: initialRoute,
        ),
      ),
    );
  }
}
