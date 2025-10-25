import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
                    Expanded(
                      child: Text(
                        'نسيت كلمة المرور',
                        textAlign: TextAlign.center,
                        style: textStyles.font20PrimaryBold,
                      ),
                    ),
                    SizedBox(width: 48.w), // To balance the back button
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Verification Code Section
              Text('رمز التحقق', style: textStyles.font28PrimaryMedium),

              SizedBox(height: 16.h),

              Text(
                'فضلا أدخل رمز التحقق المرسل على الإيميل',
                textAlign: TextAlign.center,
                style: textStyles.font14GrayRegular,
              ),

              SizedBox(height: 40.h),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    width: 50.w,
                    height: 50.h,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: textStyles.font18PrimaryBold,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: ColorsManager.kLightPurple,
                            width: 2.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: ColorsManager.kLightPurple,
                            width: 2.w,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: ColorsManager.kPrimaryColor,
                            width: 2.w,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 4) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        } else {
                          if (index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 24.h),

              // Didn't receive code text
              Text('لم تستلم الرمز ؟', style: textStyles.font14GrayRegular),

              SizedBox(height: 8.h),

              // Resend code link
              GestureDetector(
                onTap: () {
                  // Handle resend code
                },
                child: Text(
                  'إعادة إرسال الرمز',
                  style: textStyles.font14PrimaryBold,
                ),
              ),

              SizedBox(height: 40.h),

              // Progress indicator
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('1 of 2', style: textStyles.font12GrayRegular),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: ColorsManager.kLightGray,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.r),
                                  color: ColorsManager.kPrimaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.r),
                                  color: ColorsManager.kLightGray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Enter Code Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle OTP verification
                      String otp = _controllers
                          .map((controller) => controller.text)
                          .join('');
                      if (otp.length == 5) {
                        // Navigate to new password page
                        Navigator.pushNamed(context, Routes.newPasswordView);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'إدخال الرمز',
                      style: textStyles.font16WhiteBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
