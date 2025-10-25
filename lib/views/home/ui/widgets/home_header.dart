import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onLocationTap;
  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  const HomeHeader({
    super.key,
    required this.onLocationTap,
    required this.onSearchTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Top row with notification and location
          Row(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: ColorsManager.kPrimaryColor,
                size: 24.sp,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onLocationTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: ColorsManager.kPrimaryColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text('التوصيل لـ', style: textStyles.font16PrimaryBold),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorsManager.kPrimaryColor,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Location subtitle
          Align(
            alignment: Alignment.centerRight,
            child: Text('اختر موقعك', style: textStyles.font12GrayRegular),
          ),

          SizedBox(height: 16.h),

          // Search bar
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: ColorsManager.kLightGray,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.tune,
                    color: ColorsManager.kPrimaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'ابحث عن المنتجات...',
                      style: textStyles.font14GrayRegular,
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: ColorsManager.kPrimaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

