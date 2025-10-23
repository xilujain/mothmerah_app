// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/assets/img_manager.dart';
import 'package:mothmerah_app/core/extensions/navigation.dart';
import 'package:mothmerah_app/core/helpers/spacing.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/app_text_form_field.dart';
import 'package:mothmerah_app/core/widgets/main_button.dart';
import 'package:mothmerah_app/core/widgets/second_button.dart';
import 'package:mothmerah_app/views/auth/login/ui/logic/cubit/sign_in_cubit.dart';
import 'package:mothmerah_app/views/auth/login/ui/logic/cubit/sign_in_state.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state.user != null) {
            context.pushReplacementNamed(Routes.profileView);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "logo",
                    child: Image.asset(
                      ImageManager.logo,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  verticalSpace(42.h),
                  Align(
                    child: Text(
                      'لتسجيل الدخول إلى حسابك',
                      style: TextStyles(context).font20PrimaryMedium,
                    ),
                  ),
                  verticalSpace(40.h),

                  AppTextFormField(
                    controller: _phoneController,
                    hintText: 'رقم الجوال (+966)',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      context.read<SignInCubit>().updatePhoneNumber(value);
                    },
                  ),
                  verticalSpace(20.h),

                  AppTextFormField(
                    isObscureText: true,
                    hintText: 'كلمة المرور',
                    controller: _passwordController,
                    onChanged: (value) {
                      context.read<SignInCubit>().updatePassword(value);
                    },
                  ),

                  if (state.error != null) ...[
                    verticalSpace(20.h),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              state.error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () {
                              context.read<SignInCubit>().clearError();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],

                  verticalSpace(30.h),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        context.pushNamed(Routes.forgetPasswordView);
                      },
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyles(context).font14PrimaryRegular
                            .copyWith(color: ColorsManager.kPrimaryColor),
                      ),
                    ),
                  ),

                  // Login Button
                  MainButton(
                    text: 'تسجيل الدخول',
                    onTap: () {
                      state.isLoading
                          ? null
                          : context.read<SignInCubit>().login();
                    },
                  ),

                  verticalSpace(18.h),

                  SecondButton(
                    text: 'تسجيل ',
                    onTap: () {
                      context.pushNamed(Routes.signupView);
                    },
                  ),

                  verticalSpace(20.h),

                  // Demo Credentials Hint
                  // Container(
                  //   padding: const EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[100],
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Demo Credentials:',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.grey[700],
                  //         ),
                  //       ),
                  //       const SizedBox(height: 4),
                  //       vertic
                  //       const Text('user@example.com / password123'),
                  //       const Text('admin@example.com / admin123'),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
