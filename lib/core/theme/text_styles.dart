import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/font_weight_helper.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);
  TextStyle get font14PrimaryBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font14PrimaryRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font14PrimaryMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font16PrimaryRegular => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font16PrimaryMedium => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font14WhiteRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.white,
    fontFamily: 'Tajawal',
  );
  TextStyle get font20PrimaryBold => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font20PrimaryMedium => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font24PrimaryMedium => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font28PrimaryMedium => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );

  TextStyle get font11PrimarykRegular => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
  TextStyle get font13PrimaryMedium => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );

  // Additional styles for OTP page
  TextStyle get font18PrimaryBold => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );

  TextStyle get font14GrayRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kGray,
    fontFamily: 'Tajawal',
  );

  TextStyle get font14GrayMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.kGray,
    fontFamily: 'Tajawal',
  );

  TextStyle get font16WhiteBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
    fontFamily: 'Tajawal',
  );

  TextStyle get font12GrayRegular => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.kGray,
    fontFamily: 'Tajawal',
  );

  TextStyle get font16PrimaryBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.kPrimaryColor,
    fontFamily: 'Tajawal',
  );
}
