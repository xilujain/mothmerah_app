// screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/assets/img_manager.dart';
import 'package:mothmerah_app/core/extensions/navigation.dart';
import 'package:mothmerah_app/core/helpers/spacing.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/app_text_form_field.dart';
import 'package:mothmerah_app/core/widgets/main_button.dart';
import 'package:mothmerah_app/views/auth/sign_up/data/signup_repository.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_cubit.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/logic/cubit/sign_up_state.dart';
import 'package:mothmerah_app/views/auth/sign_up/ui/widgets/terms_and_conditions_dialog.dart';

// SignUpView

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _showTermsDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const TermsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.user != null) {
              context.pushReplacementNamed(Routes.splashView);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.asset(ImageManager.logo, width: 80, height: 80),
                  verticalSpace(20.h),
                  AppTextFormField(
                    controller: _nameController,
                    hintText: 'الاسم الكامل',
                    onChanged: (value) =>
                        context.read<SignupCubit>().updateName(value),
                  ),
                  verticalSpace(20.h),
                  AppTextFormField(
                    controller: _phoneController,
                    hintText: 'رقم الجوال',
                    onChanged: (value) =>
                        context.read<SignupCubit>().updatePhoneNumber(value),
                  ),
                  verticalSpace(20.h),
                  AppTextFormField(
                    controller: _emailController,
                    hintText: 'البريد الإلكتروني',
                    onChanged: (value) =>
                        context.read<SignupCubit>().updateEmail(value),
                  ),
                  verticalSpace(20.h),
                  AppTextFormField(
                    controller: _passwordController,
                    isObscureText: true,
                    hintText: 'كلمة المرور',
                    onChanged: (value) =>
                        context.read<SignupCubit>().updatePassword(value),
                  ),
                  verticalSpace(20.h),
                  AppTextFormField(
                    controller: _confirmPasswordController,
                    isObscureText: true,
                    hintText: 'تأكيد كلمة المرور',
                    onChanged: (value) => context
                        .read<SignupCubit>()
                        .updateConfirmPassword(value),
                  ),
                  verticalSpace(20.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Checkbox(
                          value: state.acceptedTerms,
                          onChanged: (value) {
                            context.read<SignupCubit>().toggleTerms(
                              value ?? false,
                            );
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<SignupCubit>().toggleTerms(
                                !state.acceptedTerms,
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    style: TextStyles(
                                      context,
                                    ).font14PrimaryMedium,
                                    text: 'إقرار بالموافقة على الشروط والأحكام',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.blue[700],
                            size: 20,
                          ),
                          onPressed: () => _showTermsDialog(context),
                        ),
                      ],
                    ),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 10),
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
                            onPressed: () =>
                                context.read<SignupCubit>().clearError(),
                          ),
                        ],
                      ),
                    ),
                  ],
                  verticalSpace(20.h),
                  MainButton(
                    text: state.isLoading ? 'جاري التسجيل...' : 'تسجيل',
                    onTap: state.isLoading
                        ? () {}
                        : () => context.read<SignupCubit>().signup(),
                  ),
                  verticalSpace(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك بالفعل حساب؟ ',
                        style: TextStyles(context).font14PrimaryMedium,
                      ),
                      TextButton(
                        onPressed: () =>
                            context.pushReplacementNamed(Routes.loginView),
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyles(context).font14PrimaryMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
