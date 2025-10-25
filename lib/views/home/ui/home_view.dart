import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/views/product/ui/widgets/product_card.dart';
import 'package:mothmerah_app/views/home/ui/widgets/home_header.dart';
import 'package:mothmerah_app/views/home/ui/widgets/category_filter.dart';
import 'package:mothmerah_app/views/home/ui/widgets/promotional_banner.dart';
import 'package:mothmerah_app/views/home/ui/widgets/bottom_navigation.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_cubit.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_state.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  String _selectedCategory = 'الكل';

  // Dummy data
  final List<ProductModel> _products = [
    ProductModel(
      id: '1',
      name: 'فلفل حار',
      description: 'فلفل أحمر إنتاج محلي',
      price: 10.0,
      imageUrl: 'assets/images/chili.jpg',
      category: 'الخضار',
      weight: '500 غرام',
      calories: 45,
      isLimited: true,
      isLocal: true,
    ),
    ProductModel(
      id: '2',
      name: 'بصل',
      description: 'بصل طازج',
      price: 10.0,
      imageUrl: 'assets/images/onion.jpg',
      category: 'الخضار',
      weight: '2 كغ',
      calories: 40,
      isLocal: true,
    ),
    ProductModel(
      id: '3',
      name: 'بروكلي',
      description: 'بروكلي طازج',
      price: 10.0,
      imageUrl: 'assets/images/broccoli.jpg',
      category: 'الخضار',
      weight: '5 كغ',
      calories: 35,
    ),
    ProductModel(
      id: '4',
      name: 'خيار',
      description: 'خيار طازج',
      price: 10.0,
      imageUrl: 'assets/images/cucumber.jpg',
      category: 'الخضار',
      weight: '5 كغ',
      calories: 16,
    ),
    ProductModel(
      id: '5',
      name: 'قرع',
      description: 'قرع طازج',
      price: 10.0,
      imageUrl: 'assets/images/squash.jpg',
      category: 'الخضار',
      weight: '3 كغ',
      calories: 20,
    ),
    ProductModel(
      id: '6',
      name: 'بطاطس',
      description: 'بطاطس طازجة',
      price: 10.0,
      imageUrl: 'assets/images/potato.jpg',
      category: 'الخضار',
      weight: '2 كغ',
      calories: 77,
      isLimited: true,
      isLocal: true,
    ),
    ProductModel(
      id: '7',
      name: 'فلفل ملون',
      description: 'فلفل أحمر وأخضر',
      price: 10.0,
      imageUrl: 'assets/images/peppers.jpg',
      category: 'الخضار',
      weight: '1 كغ',
      calories: 30,
      isLimited: true,
    ),
    ProductModel(
      id: '8',
      name: 'ثوم',
      description: 'ثوم طازج',
      price: 10.0,
      imageUrl: 'assets/images/garlic.jpg',
      category: 'الخضار',
      weight: '500 غرام',
      calories: 149,
    ),
    ProductModel(
      id: '9',
      name: 'ليمون',
      description: 'ليمون طازج',
      price: 10.0,
      imageUrl: 'assets/images/lime.jpg',
      category: 'الفواكه',
      weight: '1 كغ',
      calories: 30,
    ),
  ];

  final List<String> _categories = [
    'الكل',
    'الموسمية',
    'المحلية',
    'المستوردة',
    'الورقيات',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
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
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                HomeHeader(
                  onLocationTap: () {
                    // Handle location selection
                  },
                  onSearchTap: () {
                    // Handle search
                  },
                  onFilterTap: () {
                    // Handle filter
                  },
                ),

                // Category Filters
                CategoryFilter(
                  categories: _categories,
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),

                // Content
                Expanded(
                  child: ScrollableWrapper(
                    child: Column(
                      children: [
                        // Promotional Banner
                        PromotionalBanner(
                          onBannerTap: (index) {
                            // Handle banner tap
                          },
                        ),

                        SizedBox(height: 20.h),

                        // Products Grid
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                ),
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final product = _products[index];
                              return ProductCard(
                                product: product,
                                onAddToCart: () {
                                  // Add to cart using CartCubit
                                  context.read<CartCubit>().addToCart(product);
                                },
                                onTap: () {
                                  // Navigate to product detail
                                  Navigator.pushNamed(
                                    context,
                                    Routes.productDetailView,
                                    arguments: product,
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 80.h), // Space for bottom navigation
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(
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
                  Navigator.pushNamed(context, Routes.cartView);
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
                  // Already on home view, do nothing
                  break;
              }
            },
          ),
        );
      },
    );
  }
}
