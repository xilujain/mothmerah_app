import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/auth/new_password/data/new_password_repository.dart';
import 'package:mothmerah_app/views/auth/new_password/ui/logic/cubit/new_password_cubit.dart';
import 'package:mothmerah_app/views/auth/new_password/ui/logic/cubit/new_password_state.dart';
import 'package:dio/dio.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _currentPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return BlocProvider(
      create: (context) => NewPasswordCubit(NewPasswordRepository(Dio())),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<NewPasswordCubit, NewPasswordState>(
            listener: (context, state) {
              if (state is NewPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                // Navigate back to login or main screen
                Navigator.popUntil(context, (route) => route.isFirst);
              } else if (state is NewPasswordError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<NewPasswordCubit>();

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: ColorsManager.kPrimaryColor,
                              size: 24.sp,
                            ),
                          ),
                          Text(
                            'نسيت كلمة المرور',
                            style: textStyles.font14PrimaryMedium,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Main Title
                    Text(
                      'إنشاء كلمة مرور جديدة',
                      style: textStyles.font28PrimaryMedium,
                    ),

                    SizedBox(height: 40.h),

                    // Password Input Fields
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          // Current Password Field
                          TextField(
                            controller: _currentPasswordController,
                            focusNode: _currentPasswordFocus,
                            obscureText: !cubit.isPasswordVisible,
                            textAlign: TextAlign.right,
                            style: textStyles.font16PrimaryRegular,
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور الحالية',
                              hintStyle: textStyles.font14GrayRegular,
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

                          SizedBox(height: 16.h),

                          // New Password Field
                          TextField(
                            controller: _newPasswordController,
                            focusNode: _newPasswordFocus,
                            obscureText: !cubit.isPasswordVisible,
                            textAlign: TextAlign.right,
                            style: textStyles.font16PrimaryRegular,
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور الجديدة',
                              hintStyle: textStyles.font14GrayRegular,
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

                          SizedBox(height: 16.h),

                          // Confirm New Password Field
                          TextField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            obscureText: !cubit.isPasswordVisible,
                            textAlign: TextAlign.right,
                            style: textStyles.font16PrimaryRegular,
                            decoration: InputDecoration(
                              hintText: 'تأكيد كلمة المرور الجديدة',
                              hintStyle: textStyles.font14GrayRegular,
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

                          SizedBox(height: 16.h),

                          // Show Password Toggle
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                cubit.togglePasswordVisibility();
                              },
                              child: Text(
                                'إظهار كلمة المرور',
                                style: textStyles.font14PrimaryMedium,
                              ),
                            ),
                          ),

                          SizedBox(height: 40.h),

                          // Progress indicator
                          Row(
                            children: [
                              Text(
                                '2 of 2',
                                style: textStyles.font12GrayRegular,
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Container(
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.r),
                                    color: ColorsManager.kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40.h),

                          // Update Password Button
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: state is NewPasswordLoading
                                  ? null
                                  : () {
                                      cubit.updatePassword(
                                        currentPassword:
                                            _currentPasswordController.text,
                                        newPassword:
                                            _newPasswordController.text,
                                        confirmNewPassword:
                                            _confirmPasswordController.text,
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                elevation: 0,
                              ),
                              child: state is NewPasswordLoading
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.w,
                                      ),
                                    )
                                  : Text(
                                      'إدخال الرمز',
                                      style: textStyles.font16WhiteBold,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
