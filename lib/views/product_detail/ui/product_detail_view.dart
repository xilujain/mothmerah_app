import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_cubit.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_state.dart';
import 'package:mothmerah_app/views/product_detail/ui/logic/cubit/product_detail_cubit.dart';
import 'package:mothmerah_app/views/product_detail/ui/logic/cubit/product_detail_state.dart';
import 'package:mothmerah_app/views/product_detail/ui/widgets/product_image_section.dart';
import 'package:mothmerah_app/views/product_detail/ui/widgets/product_info_section.dart';
import 'package:mothmerah_app/views/product_detail/ui/widgets/other_products_section.dart';
import 'package:mothmerah_app/views/product_detail/ui/widgets/add_to_cart_button.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late ProductDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ProductDetailCubit();
    _cubit.loadProduct(widget.product);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم إضافة ${state.product.name} إلى السلة'),
                backgroundColor: ColorsManager.kPrimaryColor,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, cartState) {
          return BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              if (state is! ProductDetailLoaded) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    'التوصيل لـ',
                    style: TextStyles(context).font18BlackBold,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.location_on,
                        color: ColorsManager.kPrimaryColor,
                      ),
                      onPressed: () {
                        // Handle location selection
                      },
                    ),
                  ],
                ),
                body: ScrollableWrapper(
                  child: Column(
                    children: [
                      // Product Image Section
                      ProductImageSection(
                        product: state.product,
                        currentImageIndex: state.currentImageIndex,
                        onImageChanged: (index) {
                          _cubit.changeImage(index);
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Product Info Section
                      ProductInfoSection(
                        product: state.product,
                        quantity: state.quantity,
                        onQuantityChanged: (quantity) {
                          _cubit.updateQuantity(quantity);
                        },
                      ),

                      SizedBox(height: 30.h),

                      // Other Products Section
                      OtherProductsSection(
                        onProductTap: (product) {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.productDetailView,
                            arguments: product,
                          );
                        },
                        onAddToCart: (product) {
                          context.read<CartCubit>().addToCart(product);
                        },
                      ),

                      SizedBox(height: 100.h), // Space for bottom button
                    ],
                  ),
                ),
                bottomNavigationBar: AddToCartButton(
                  product: state.product,
                  quantity: state.quantity,
                  onAddToCart: () {
                    context.read<CartCubit>().addToCart(
                      state.product,
                      quantity: state.quantity,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
