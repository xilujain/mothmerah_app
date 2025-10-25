import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class ProductImageSection extends StatelessWidget {
  final ProductModel product;
  final Function(int) onImageTap;

  const ProductImageSection({
    super.key,
    required this.product,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        children: [
          // Main product image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.kLightGray,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 120.sp,
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          ),

          // Page indicators
          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: index == 2
                        ? ColorsManager.kPrimaryColor
                        : Colors.white.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

