import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductModel product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name and price
          Row(
            children: [
              Expanded(
                child: Text(
                  '${product.name} ${product.price.toInt()} ﷼',
                  style: textStyles.font20BlackBold,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Tags
          Row(
            children: [
              if (product.isLocal)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text('إنتاج محلي', style: textStyles.font10WhiteBold),
                ),
              if (product.isLocal) SizedBox(width: 8.w),
              if (product.isLimited)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ColorsManager.kPrimaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text('كمية محدودة', style: textStyles.font10WhiteBold),
                ),
            ],
          ),

          SizedBox(height: 12.h),

          // Calories
          Text(
            '${product.calories} سعرة حرارية',
            style: textStyles.font14GrayRegular,
          ),
        ],
      ),
    );
  }
}
