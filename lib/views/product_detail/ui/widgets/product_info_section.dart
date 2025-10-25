import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final Function(int) onQuantityChanged;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name and price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(product.name, style: textStyles.font20BlackBold),
              ),
              Text(
                '${product.price.toStringAsFixed(0)} ر.س',
                style: textStyles.font20PrimaryBold,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Tags row
          Row(
            children: [
              if (product.isLocal) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text('إنتاج محلي', style: textStyles.font12WhiteBold),
                ),
                SizedBox(width: 8.w),
              ],
              if (product.isLimited) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ColorsManager.kPrimaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text('كمية محدودة', style: textStyles.font12WhiteBold),
                ),
                SizedBox(width: 8.w),
              ],
            ],
          ),

          SizedBox(height: 12.h),

          // Calories tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              '${product.calories} سعرة حرارية',
              style: textStyles.font14PrimaryRegular,
            ),
          ),

          SizedBox(height: 12.h),

          // Description
          Text(product.description, style: textStyles.font14GrayRegular),

          SizedBox(height: 20.h),

          // Quantity selector
          Row(
            children: [
              Text('الكمية:', style: textStyles.font16PrimaryRegular),
              SizedBox(width: 20.w),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () => onQuantityChanged(quantity - 1)
                          : null,
                      icon: Icon(
                        Icons.remove,
                        color: quantity > 1
                            ? ColorsManager.kPrimaryColor
                            : Colors.grey,
                      ),
                    ),
                    Container(
                      width: 40.w,
                      alignment: Alignment.center,
                      child: Text(
                        quantity.toString(),
                        style: textStyles.font16PrimaryRegular,
                      ),
                    ),
                    IconButton(
                      onPressed: () => onQuantityChanged(quantity + 1),
                      icon: Icon(Icons.add, color: ColorsManager.kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
