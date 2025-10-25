import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class ProductImageSection extends StatelessWidget {
  final ProductModel product;
  final int currentImageIndex;
  final Function(int) onImageChanged;

  const ProductImageSection({
    super.key,
    required this.product,
    required this.currentImageIndex,
    required this.onImageChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy images for the product
    final List<String> productImages = [
      product.imageUrl,
      'assets/images/chili_2.jpg',
      'assets/images/chili_3.jpg',
      'assets/images/chili_4.jpg',
      'assets/images/chili_5.jpg',
    ];

    return Container(
      height: 300.h,
      child: Stack(
        children: [
          // Main product image
          Center(
            child: Container(
              width: 250.w,
              height: 250.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  productImages[currentImageIndex],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image,
                        size: 100.sp,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Zoom icon
          Positioned(
            left: 20.w,
            top: 20.h,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.zoom_out_map,
                color: ColorsManager.kPrimaryColor,
                size: 20.sp,
              ),
            ),
          ),

          // Share icon
          Positioned(
            left: 20.w,
            top: 70.h,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.share,
                color: ColorsManager.kPrimaryColor,
                size: 20.sp,
              ),
            ),
          ),

          // Image indicators
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                productImages.length,
                (index) => GestureDetector(
                  onTap: () => onImageChanged(index),
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentImageIndex
                          ? ColorsManager.kPrimaryColor
                          : Colors.grey[300],
                    ),
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
