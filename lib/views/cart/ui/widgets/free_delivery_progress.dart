import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class FreeDeliveryProgress extends StatelessWidget {
  final double currentAmount;
  final double targetAmount;

  const FreeDeliveryProgress({
    super.key,
    required this.currentAmount,
    required this.targetAmount,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);
    final progress = (currentAmount / targetAmount).clamp(0.0, 1.0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(
            'أضف ${(targetAmount - currentAmount).toInt()} للسلة للحصول على التوصيل المجاني',
            style: textStyles.font12WhiteBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
              ColorsManager.kPrimaryColor,
            ),
            minHeight: 6.h,
          ),
        ],
      ),
    );
  }
}

