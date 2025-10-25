import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class BestOptionsSection extends StatelessWidget {
  final Function(ProductModel) onProductTap;
  final Function(ProductModel) onAddToCart;

  const BestOptionsSection({
    super.key,
    required this.onProductTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    // Dummy best options
    final bestOptions = [
      ProductModel(
        id: '1',
        name: 'اسم المنتج',
        description: 'وصف المنتج',
        price: 10.0,
        imageUrl: 'assets/images/cucumber.jpg',
        category: 'الخضار',
        weight: 'صندوق ٥ كغ',
        calories: 16,
      ),
      ProductModel(
        id: '2',
        name: 'اسم المنتج',
        description: 'وصف المنتج',
        price: 10.0,
        imageUrl: 'assets/images/cucumber.jpg',
        category: 'الخضار',
        weight: 'صندوق ٥ كغ',
        calories: 16,
      ),
      ProductModel(
        id: '3',
        name: 'اسم المنتج',
        description: 'وصف المنتج',
        price: 10.0,
        imageUrl: 'assets/images/cucumber.jpg',
        category: 'الخضار',
        weight: 'صندوق ٥ كغ',
        calories: 16,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text('أفضل الخيارات', style: textStyles.font18PrimaryBold),
        ),

        SizedBox(height: 12.h),

        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: bestOptions.length,
            itemBuilder: (context, index) {
              final product = bestOptions[index];
              return Container(
                width: 100.w,
                margin: EdgeInsets.only(right: 12.w),
                child: Column(
                  children: [
                    // Product Image
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onProductTap(product),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 40.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Add to cart button
                    GestureDetector(
                      onTap: () => onAddToCart(product),
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16.sp,
                          color: Colors.purple,
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Product name
                    Text(
                      product.name,
                      style: textStyles.font10BlackBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 2.h),

                    // Weight
                    Text(
                      product.weight,
                      style: textStyles.font8GrayRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 2.h),

                    // Price
                    Text(
                      '${product.price.toInt()} ﷼',
                      style: textStyles.font10PrimaryBold,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

