import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.product,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: ColorsManager.kLightGray,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 30.sp,
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: textStyles.font14BlackBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${product.price.toInt()} x',
                  style: textStyles.font12GrayRegular,
                ),
                SizedBox(height: 8.h),

                // Quantity Selector
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onQuantityChanged(product.quantity - 1),
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.kLightGray,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 16.sp,
                          color: ColorsManager.kPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 32.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Text(
                          product.quantity.toString(),
                          style: textStyles.font12PrimaryBold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => onQuantityChanged(product.quantity + 1),
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.kLightGray,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16.sp,
                          color: ColorsManager.kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Price and Remove
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(product.price * product.quantity).toInt()} ﷼',
                style: textStyles.font14PrimaryBold,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

