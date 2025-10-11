import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/assets/img_manager.dart';
import 'package:mothmerah_app/core/extensions/navigation.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/app_text_form_field.dart';
import 'package:mothmerah_app/core/widgets/main_button.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_cubit.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_state.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.user != null) {
              context.pushReplacementNamed('/splash');
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Image.asset(ImageManager.logo, width: 80, height: 80),
                  const SizedBox(height: 40),

                  // Name Field
                  AppTextFormField(
                    hintText: 'الاسم الكامل',
                    controller: _nameController,
                    onChanged: (value) {
                      context.read<SignupCubit>().updateName(value);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  AppTextFormField(
                    controller: _emailController,
                    hintText: 'البريد الإلكتروني',
                    onChanged: (value) {
                      context.read<SignupCubit>().updateEmail(value);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  AppTextFormField(
                    controller: _passwordController,
                    isObscureText: true,
                    hintText: 'كلمة المرور',
                    onChanged: (value) {
                      context.read<SignupCubit>().updatePassword(value);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  AppTextFormField(
                    controller: _confirmPasswordController,
                    isObscureText: true,
                    hintText: 'تأكيد كلمة المرور',
                    onChanged: (value) {
                      context.read<SignupCubit>().updateConfirmPassword(value);
                    },
                  ),

                  // Error Message
                  if (state.error != null) ...[
                    const SizedBox(height: 20),
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
                              context.read<SignupCubit>().clearError();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'للموافقة على الشروط و الأحكام',
                          style: TextStyles(context).font14PrimaryRegular,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed(Routes.loginView);
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  MainButton(
                    text: 'تسجيل ',
                    width: double.infinity,
                    onTap: () => state.isLoading
                        ? null
                        : context.read<SignupCubit>().signup(),
                  ),

                  const SizedBox(height: 60),

                  // Login Redirect
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'هل لديك بالفعل حساب؟',
                          style: TextStyles(context).font14PrimaryRegular,
                        ),
                        TextSpan(
                          text: 'سجل دخولك',
                          style: TextStyles(context).font14PrimaryRegular,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed(Routes.loginView);
                            },
                        ),
                      ],
                    ),
                  ),

                  // Demo Note
                  // Container(
                  //   padding: const EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue[50],
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: const Column(
                  //     children: [
                  //       Text(
                  //         'Note:',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.blue,
                  //         ),
                  //       ),
                  //       SizedBox(height: 4),
                  //       Text(
                  //         'user@example.com and admin@example.com are already registered. Try with a different email.',
                  //         style: TextStyle(color: Colors.blue),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
