import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
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

class _ProductDetailViewState extends State<ProductDetailView>
    with TickerProviderStateMixin {
  late ProductDetailCubit _cubit;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _cubit = ProductDetailCubit();
    _cubit.loadProduct(widget.product);

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _cubit.close();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemAdded) {
            _showSuccessSnackBar('تم إضافة ${state.product.name} إلى السلة');
          } else if (state is CartError) {
            _showErrorSnackBar(state.error);
          }
        },
        builder: (context, cartState) {
          return BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              if (state is! ProductDetailLoaded) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorsManager.kPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'جاري تحميل المنتج...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Scaffold(
                backgroundColor: Colors.white,
                body: CustomScrollView(
                  slivers: [
                    // Animated App Bar
                    SliverAppBar(
                      expandedHeight: 120.h,
                      floating: false,
                      pinned: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: Container(
                        margin: EdgeInsets.all(8.w),
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
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 60.h,
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: ColorsManager.kPrimaryColor,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'التوصيل لـ',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.kPrimaryColor
                                              .withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: Text(
                                          'اختر موقعك',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorsManager.kPrimaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Product Content
                    SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
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

                              SizedBox(height: 24.h),

                              // Product Info Section
                              ProductInfoSection(
                                product: state.product,
                                quantity: state.quantity,
                                onQuantityChanged: (quantity) {
                                  _cubit.updateQuantity(quantity);
                                },
                              ),

                              SizedBox(height: 32.h),

                              // // Other Products Section
                              // OtherProductsSection(
                              //   onProductTap: (product) {
                              //     Navigator.pushReplacementNamed(
                              //       context,
                              //       Routes.productDetailView,
                              //       arguments: product,
                              //     );
                              //   },
                              //   onAddToCart: (product) {
                              //     context.read<CartCubit>().addToCart(product);
                              //   },
                              // ),

                              // SizedBox(
                              //   height: 100.h,
                              // ), // Space for bottom button
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: AddToCartButton(
                    product: state.product,
                    quantity: state.quantity,
                    onAddToCart: () {
                      context.read<CartCubit>().addToCart(
                        state.product,
                        quantity: state.quantity,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(message),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
