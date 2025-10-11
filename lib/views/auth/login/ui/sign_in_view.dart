import 'package:flutter/material.dart';
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

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool isObsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  // key: context.read<SignInCubit>().formKey,
                  child: Column(
                    children: [
                      verticalSpace(30),
                      Image.asset(
                        ImageManager.logo,
                        width: 120.w,
                        height: 120.h,
                        color: ColorsManager.kPrimaryColor,
                      ),
                      verticalSpace(30),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'لتسجيل الدخول إلى حسابك',
                          style: TextStyles(context).font20PrimaryMedium,
                        ),
                      ),
                      verticalSpace(20),
                      AppTextFormField(
                        // controller: context.read<LoginCubit>().emailController,
                        hintText: 'الإيميل أو رقم الهاتف المحمول',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال البريد الإلكتروني';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(24),
                      AppTextFormField(
                        // controller: context
                        //     .read<LoginCubit>()
                        //     .passwordController,
                        hintText: 'كلمة المرور',
                        isObscureText: isObsecureText,

                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObsecureText = !isObsecureText;
                            });
                          },
                          child: Icon(
                            isObsecureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(24),
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
                      verticalSpace(64),
                      MainButton(
                        text: 'تسجيل الدخول',
                        onTap: () {
                          // validateThenDoLogin(context);
                        },
                      ),
                      // SignUpWithGoogle(),
                      verticalSpace(20),
                      SecondButton(
                        text: 'تسجيل',
                        onTap: () {
                          // validateThenDoLogin(context);
                        },
                      ),
                      // LoginBlocListener(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
