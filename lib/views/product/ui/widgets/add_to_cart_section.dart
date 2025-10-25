import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class AddToCartSection extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onAddToCart;

  const AddToCartSection({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onAddToCart,
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Quantity selector
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (quantity > 1) {
                    onQuantityChanged(quantity - 1);
                  }
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.kLightGray,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: ColorsManager.kPrimaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    quantity.toString(),
                    style: textStyles.font16PrimaryBold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () => onQuantityChanged(quantity + 1),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.kLightGray,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.add,
                    color: ColorsManager.kPrimaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Add to cart button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text('أضف إلى السلة', style: textStyles.font16WhiteBold),
            ),
          ),

          SizedBox(width: 12.w),

          // Price
          Text(
            '${(product.price * quantity).toInt()} ﷼',
            style: textStyles.font16PrimaryBold,
          ),
        ],
      ),
    );
  }
}

