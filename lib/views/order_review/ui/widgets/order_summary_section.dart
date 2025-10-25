import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class OrderSummarySection extends StatelessWidget {
  final double orderTotal;
  final double deliveryFee;
  final double total;

  const OrderSummarySection({
    super.key,
    required this.orderTotal,
    required this.deliveryFee,
    required this.total,
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
            color: Colors.black.withOpacity(0.05),
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
            Text('ملخص الطلب', style: textStyles.font16PrimaryBold),
            SizedBox(height: 16.h),
            _buildSummaryRow('مجموع الطلب', orderTotal, textStyles),
            SizedBox(height: 8.h),
            _buildSummaryRow('رسوم التوصيل', deliveryFee, textStyles),
            SizedBox(height: 8.h),
            Divider(),
            SizedBox(height: 8.h),
            _buildSummaryRow('المجموع', total, textStyles, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount,
    TextStyles textStyles, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? textStyles.font18BlackBold
              : textStyles.font14BlackBold,
        ),
        Text(
          '${amount.toStringAsFixed(0)} ر.س',
          style: isTotal
              ? textStyles.font16PrimaryBold
              : textStyles.font14PrimaryBold,
        ),
      ],
    );
  }
}
