import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'package:mothmerah_app/views/product/ui/widgets/product_card.dart';

class OtherProductsSection extends StatelessWidget {
  final Function(ProductModel) onProductTap;

  const OtherProductsSection({super.key, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    // Dummy other products
    final otherProducts = [
      ProductModel(
        id: '1',
        name: 'اسم المنتج',
        description: 'وصف المنتج',
        price: 10.0,
        imageUrl: 'assets/images/chili.jpg',
        category: 'الخضار',
        weight: 'صندوق ٢ كغ',
        calories: 45,
      ),
      ProductModel(
        id: '2',
        name: 'اسم المنتج',
        description: 'وصف المنتج',
        price: 10.0,
        imageUrl: 'assets/images/onion.jpg',
        category: 'الخضار',
        weight: 'كرتون ٥ كغ',
        calories: 40,
      ),
      ProductModel(
        id: '3',
        name: 'اسم المنتج',
        description: 'وصف المنتج',
        price: 10.0,
        imageUrl: 'assets/images/broccoli.jpg',
        category: 'الخضار',
        weight: 'صندوق ٥ كغ',
        calories: 35,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text('منتجات اخرى', style: textStyles.font18BlackBold),
        ),

        SizedBox(height: 12.h),

        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: otherProducts.length,
            itemBuilder: (context, index) {
              final product = otherProducts[index];
              return Container(
                width: 150.w,
                margin: EdgeInsets.only(right: 12.w),
                child: ProductCard(
                  product: product,
                  onAddToCart: () {
                    // Handle add to cart
                  },
                  onTap: () => onProductTap(product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

