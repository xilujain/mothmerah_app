import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class CheckoutSection extends StatelessWidget {
  final double totalAmount;
  final VoidCallback onCheckout;

  const CheckoutSection({
    super.key,
    required this.totalAmount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Cart icon with count
          Stack(
            children: [
              Icon(
                Icons.shopping_cart,
                color: ColorsManager.kPrimaryColor,
                size: 24.sp,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 16.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('1', style: textStyles.font10WhiteBold),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 12.w),

          // Total amount
          Text('${totalAmount.toInt()} ﷼', style: textStyles.font16PrimaryBold),

          const Spacer(),

          // Checkout button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text('اذهب للدفع', style: textStyles.font16WhiteBold),
            ),
          ),
        ],
      ),
    );
  }
}

