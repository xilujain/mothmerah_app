import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class ProfileInfoBlock extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileInfoBlock({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.kLightGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textStyles.font16PrimaryBold),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const ProfileInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(label, style: textStyles.font14PrimaryBold),
            const Spacer(),
            Text(value, style: textStyles.font14GrayRegular),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorsManager.kPrimaryColor,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileActionRow extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ProfileActionRow({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              label,
              style: textStyles.font14PrimaryBold.copyWith(color: color),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: color, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
