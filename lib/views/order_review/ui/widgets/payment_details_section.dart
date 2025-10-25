import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class PaymentDetailsSection extends StatelessWidget {
  final String paymentMethod;
  final VoidCallback onPaymentChange;

  const PaymentDetailsSection({
    super.key,
    required this.paymentMethod,
    required this.onPaymentChange,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('تفاصيل الدفع', style: textStyles.font16PrimaryBold),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text('طرق الدفع', style: textStyles.font14BlackBold),
                  const Spacer(),
                  Text(paymentMethod, style: textStyles.font14PrimaryBold),
                  SizedBox(width: 8.w),
                  TextButton(
                    onPressed: onPaymentChange,
                    child: Text('تغيير', style: textStyles.font14PrimaryBold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
