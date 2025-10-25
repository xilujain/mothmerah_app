import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'package:mothmerah_app/views/product/ui/widgets/product_detail_header.dart';
import 'package:mothmerah_app/views/product/ui/widgets/product_image_section.dart';
import 'package:mothmerah_app/views/product/ui/widgets/product_info_section.dart';
import 'package:mothmerah_app/views/product/ui/widgets/other_products_section.dart';
import 'package:mothmerah_app/views/product/ui/widgets/add_to_cart_section.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            ProductDetailHeader(
              onBackTap: () => Navigator.pop(context),
              onShareTap: () {
                // Handle share
              },
              onFullScreenTap: () {
                // Handle full screen
              },
            ),

            // Content
            Expanded(
              child: ScrollableWrapper(
                child: Column(
                  children: [
                    // Product Image Section
                    ProductImageSection(
                      product: widget.product,
                      onImageTap: (index) {
                        // Handle image tap
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Product Info Section
                    ProductInfoSection(product: widget.product),

                    SizedBox(height: 20.h),

                    // Other Products Section
                    OtherProductsSection(
                      onProductTap: (product) {
                        // Navigate to product detail
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailView(product: product),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 100.h), // Space for bottom section
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddToCartSection(
        product: widget.product,
        quantity: _quantity,
        onQuantityChanged: (quantity) {
          setState(() {
            _quantity = quantity;
          });
        },
        onAddToCart: () {
          // Handle add to cart
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم إضافة ${widget.product.name} إلى السلة'),
              backgroundColor: ColorsManager.kPrimaryColor,
            ),
          );
        },
      ),
    );
  }
}
