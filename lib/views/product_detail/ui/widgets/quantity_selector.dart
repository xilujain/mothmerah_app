import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback? onRemove;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add button
          GestureDetector(
            onTap: () => onQuantityChanged(quantity + 1),
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: ColorsManager.kPrimaryColor,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.add,
                color: ColorsManager.kPrimaryColor,
                size: 16.sp,
              ),
            ),
          ),

          // Quantity display
          Container(
            width: 40.w,
            height: 32.h,
            alignment: Alignment.center,
            child: Text(
              quantity.toString(),
              style: textStyles.font16PrimaryRegular,
            ),
          ),

          // Remove button
          GestureDetector(
            onTap: quantity > 1
                ? () => onQuantityChanged(quantity - 1)
                : onRemove,
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: quantity > 1
                      ? ColorsManager.kPrimaryColor
                      : Colors.red,
                  width: 1,
                ),
              ),
              child: Icon(
                quantity > 1 ? Icons.remove : Icons.delete,
                color: quantity > 1 ? ColorsManager.kPrimaryColor : Colors.red,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
