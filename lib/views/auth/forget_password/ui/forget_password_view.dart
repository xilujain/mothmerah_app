import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/assets/img_manager.dart';
import 'package:mothmerah_app/core/helpers/spacing.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/main_button.dart';
import 'package:mothmerah_app/views/auth/forget_password/data/forget_password_repository.dart';
import 'package:mothmerah_app/views/auth/forget_password/ui/logic/cubit/forget_password_cubit.dart';
import 'package:mothmerah_app/views/auth/forget_password/ui/logic/cubit/forget_password_state.dart';
import 'package:dio/dio.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _phoneOrEmailController = TextEditingController();
  final FocusNode _phoneOrEmailFocus = FocusNode();

  @override
  void dispose() {
    _phoneOrEmailController.dispose();
    _phoneOrEmailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(ForgetPasswordRepository(Dio())),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is OtpSent) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              // Navigate to OTP view with phone/email
              Navigator.pushNamed(
                context,
                '/otp',
                arguments: state.phoneOrEmail,
              );
            } else if (state is ForgetPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ForgetPasswordCubit>();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(30.w),
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyles(context).font20PrimaryMedium,
                      ),
                    ),
                    verticalSpace(48.h),
                    Image.asset(ImageManager.forgetLogo, width: 218.w),
                    verticalSpace(56.h),
                    Align(
                      child: Text(
                        'أين ترغب بالحصول على رمز التحقق؟',
                        style: TextStyles(context).font20PrimaryMedium,
                      ),
                    ),
                    verticalSpace(40.h),

                    // Phone or Email Input
                    TextField(
                      controller: _phoneOrEmailController,
                      focusNode: _phoneOrEmailFocus,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.right,
                      style: TextStyles(context).font16PrimaryRegular,
                      decoration: InputDecoration(
                        hintText: 'رقم الجوال أو البريد الإلكتروني',
                        hintStyle: TextStyles(context).font14GrayRegular,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: ColorsManager.kLightPurple,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: ColorsManager.kLightPurple,
                            width: 1.w,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: ColorsManager.kPrimaryColor,
                            width: 1.w,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                    ),

                    verticalSpace(40.h),

                    MainButton(
                      text: 'إرسال رمز التحقق',
                      onTap: () {
                        final phoneOrEmail = _phoneOrEmailController.text
                            .trim();
                        if (phoneOrEmail.isNotEmpty) {
                          cubit.sendOtp(phoneOrEmail);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'يرجى إدخال رقم الجوال أو البريد الإلكتروني',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
