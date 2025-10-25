import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'package:mothmerah_app/views/cart/ui/widgets/cart_header.dart';
import 'package:mothmerah_app/views/cart/ui/widgets/cart_item.dart';
import 'package:mothmerah_app/views/cart/ui/widgets/best_options_section.dart';
import 'package:mothmerah_app/views/cart/ui/widgets/free_delivery_progress.dart';
import 'package:mothmerah_app/views/cart/ui/widgets/checkout_section.dart';
import 'package:mothmerah_app/views/home/ui/widgets/bottom_navigation.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_cubit.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_state.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int _selectedIndex = 1; // Cart is index 1

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        // If CartCubit is not available, show loading
        try {
          context.read<CartCubit>();
        } catch (e) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is CartLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CartError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.error, style: textStyles.font18PrimaryBold),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Reload cart by creating new CartCubit
                      context.read<CartCubit>().loadCart();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          );
        }

        final cartItems = state is CartLoaded ? state.items : <ProductModel>[];
        final totalAmount = state is CartLoaded ? state.totalAmount : 0.0;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                CartHeader(onBackTap: () => Navigator.pop(context)),

                // Content
                Expanded(
                  child: ScrollableWrapper(
                    child: Column(
                      children: [
                        // Cart Items
                        if (cartItems.isNotEmpty) ...[
                          ...cartItems.map(
                            (item) => CartItem(
                              product: item,
                              onQuantityChanged: (quantity) {
                                context.read<CartCubit>().updateQuantity(
                                  item.id,
                                  quantity,
                                );
                              },
                              onRemove: () {
                                context.read<CartCubit>().removeFromCart(
                                  item.id,
                                );
                              },
                            ),
                          ),
                        ] else ...[
                          // Empty cart
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 80.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'السلة فارغة',
                                    style: textStyles.font18GrayBold,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'أضف منتجات إلى السلة للبدء',
                                    style: textStyles.font14GrayRegular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],

                        SizedBox(height: 20.h),

                        // Best Options Section
                        BestOptionsSection(
                          onProductTap: (product) {
                            // Handle product tap
                          },
                          onAddToCart: (product) {
                            context.read<CartCubit>().addToCart(product);
                          },
                        ),

                        SizedBox(height: 20.h),

                        // Free Delivery Progress
                        FreeDeliveryProgress(
                          currentAmount: totalAmount,
                          targetAmount: 20.0,
                        ),

                        SizedBox(height: 100.h), // Space for checkout section
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Checkout section if cart has items
              if (cartItems.isNotEmpty)
                CheckoutSection(
                  totalAmount: totalAmount,
                  onCheckout: () {
                    // Handle checkout
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم الانتقال إلى الدفع'),
                        backgroundColor: ColorsManager.kPrimaryColor,
                      ),
                    );
                  },
                ),
              // Bottom navigation
              BottomNavigation(
                selectedIndex: _selectedIndex,
                onItemTapped: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });

                  // Navigate to appropriate view based on selected index
                  switch (index) {
                    case 0: // الملف الشخصي
                      Navigator.pushNamed(context, Routes.profileView);
                      break;
                    case 1: // السلة
                      // Already on cart view, do nothing
                      break;
                    case 2: // المفضلة
                      // TODO: Implement favorites view
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('صفحة المفضلة قيد التطوير'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      break;
                    case 3: // الرئيسية
                      Navigator.pushNamed(context, Routes.homeView);
                      break;
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
