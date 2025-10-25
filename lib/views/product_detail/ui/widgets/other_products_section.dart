import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class OtherProductsSection extends StatelessWidget {
  final Function(ProductModel) onProductTap;
  final Function(ProductModel) onAddToCart;

  const OtherProductsSection({
    super.key,
    required this.onProductTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    // Dummy other products
    final List<ProductModel> otherProducts = [
      ProductModel(
        id: 'other_1',
        name: 'اسم المنتج',
        description: 'صندوق ٢ كغ',
        price: 10.0,
        imageUrl: 'assets/images/chili.jpg',
        category: 'الخضار',
        weight: '2 كغ',
        calories: 45,
        isLimited: false,
        isLocal: true,
      ),
      ProductModel(
        id: 'other_2',
        name: 'اسم المنتج',
        description: 'كرتون ٥ كغ',
        price: 10.0,
        imageUrl: 'assets/images/onion.jpg',
        category: 'الخضار',
        weight: '5 كغ',
        calories: 40,
        isLimited: false,
        isLocal: true,
      ),
      ProductModel(
        id: 'other_3',
        name: 'اسم المنتج',
        description: 'صندوق ٥ كغ',
        price: 10.0,
        imageUrl: 'assets/images/broccoli.jpg',
        category: 'الخضار',
        weight: '5 كغ',
        calories: 35,
        isLimited: false,
        isLocal: true,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text('منتجات اخرى', style: textStyles.font18BlackBold),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: otherProducts.length,
            itemBuilder: (context, index) {
              final product = otherProducts[index];
              return Container(
                width: 140.w,
                margin: EdgeInsets.only(right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    GestureDetector(
                      onTap: () => onProductTap(product),
                      child: Container(
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.image,
                                  size: 40.sp,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Add to cart button
                    GestureDetector(
                      onTap: () => onAddToCart(product),
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
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

                    SizedBox(height: 8.h),

                    // Price
                    Text(
                      '${product.price.toStringAsFixed(0)} ر.س',
                      style: textStyles.font14PrimaryBold,
                    ),

                    SizedBox(height: 4.h),

                    // Product name
                    Text(
                      product.name,
                      style: textStyles.font12BlackBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 2.h),

                    // Description
                    Text(
                      product.description,
                      style: textStyles.font10GrayRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
