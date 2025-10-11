import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/assets/img_manager.dart';
import 'package:mothmerah_app/core/extensions/navigation.dart';
import 'package:mothmerah_app/core/helpers/spacing.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/main_button.dart';
import 'package:mothmerah_app/core/widgets/second_button.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
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
            verticalSpace(68.h),

            MainButton(text: 'عن طريق رسالة نصية', onTap: () {}),
            verticalSpace(26.h),
            SecondButton(
              text: 'عن طريق رسالة على الإيميل',
              onTap: () => context.pushNamed('/otp'),
            ),
          ],
        ),
      ),
    );
  }
}
