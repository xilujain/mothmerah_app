import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
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

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int _selectedIndex = 3; // الرئيسية (Home) is index 3
  String _selectedCategory = 'الكل';
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Dummy data
  final List<ProductModel> _products = [
    ProductModel(
      id: '1',
      name: 'بروكلي',
      price: 15.0,
      imageUrl: 'assets/images/Rectangle 2510.png',
      category: 'الخضار',
      weight: '2 كغ',
      calories: 18,
      isLocal: true,
    ),
    ProductModel(
      id: '2',
      name: 'خضار متنوعة',
      price: 25.0,
      imageUrl: 'assets/images/Rectangle 2511.png',
      category: 'الخضار',
      weight: '3 كغ',
      calories: 35,
      isLocal: true,
    ),
    ProductModel(
      id: '4',
      name: 'خيار',
      price: 12.0,
      imageUrl: 'assets/images/Rectangle 2518.png',
      category: 'الخضار',
      weight: '1 كغ',
      calories: 20,
      isLocal: true,
    ),
    ProductModel(
      id: '5',
      name: 'خضار جذرية',
      price: 18.0,
      imageUrl: 'assets/images/Rectangle 2519.png',
      category: 'الخضار',
      weight: '2 كغ',
      calories: 55,
      isLimited: true,
      isLocal: true,
    ),
    ProductModel(
      id: '8',
      name: 'خضار عضوية',
      price: 28.0,
      imageUrl: 'assets/images/Rectangle 2510.png',
      category: 'الخضار',
      weight: '1.8 كغ',
      calories: 30,
      isLocal: true,
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
  void initState() {
    super.initState();
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

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartItemAdded) {
          _showSuccessSnackBar('تم إضافة ${state.product.name} إلى السلة');
        } else if (state is CartError) {
          _showErrorSnackBar(state.error);
        }
      },
      builder: (context, cartState) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                // Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: HomeHeader(
                      onLocationTap: () {
                        _showLocationDialog();
                      },
                      onSearchTap: () {
                        _showSearchDialog();
                      },
                      onFilterTap: () {
                        _showFilterDialog();
                      },
                    ),
                  ),
                ),

                // Category Filters
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: CategoryFilter(
                      categories: _categories,
                      selectedCategory: _selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  ),
                ),

                // Content
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ScrollableWrapper(
                        child: Column(
                          children: [
                            // Promotional Banner
                            PromotionalBanner(
                              onBannerTap: (index) {
                                _showBannerDialog(index);
                              },
                            ),

                            SizedBox(
                              height: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 20,
                                tablet: 24,
                                desktop: 28,
                              ),
                            ),

                            // Products Grid
                            Padding(
                              padding: ResponsiveHelper.getHorizontalPadding(
                                context,
                                mobile: 16,
                                tablet: 24,
                                desktop: 32,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          ResponsiveHelper.getGridColumns(
                                            context,
                                            mobile: 2,
                                            tablet: 3,
                                            desktop: 4,
                                          ),
                                      childAspectRatio:
                                          ResponsiveHelper.getResponsiveValue(
                                            context,
                                            mobile: 0.75,
                                            tablet: 0.8,
                                            desktop: 0.85,
                                          ),
                                      crossAxisSpacing:
                                          ResponsiveHelper.getSpacing(
                                            context,
                                            mobile: 12,
                                            tablet: 16,
                                            desktop: 20,
                                          ),
                                      mainAxisSpacing:
                                          ResponsiveHelper.getSpacing(
                                            context,
                                            mobile: 12,
                                            tablet: 16,
                                            desktop: 20,
                                          ),
                                    ),
                                itemCount: _products.length,
                                itemBuilder: (context, index) {
                                  final product = _products[index];
                                  return TweenAnimationBuilder<double>(
                                    duration: Duration(
                                      milliseconds: 300 + (index * 100),
                                    ),
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: Opacity(
                                          opacity: value,
                                          child: ProductCard(
                                            product: product,
                                            onAddToCart: () {
                                              context
                                                  .read<CartCubit>()
                                                  .addToCart(product);
                                            },
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.productDetailView,
                                                arguments: product,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            SizedBox(
                              height: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 80,
                                tablet: 100,
                                desktop: 120,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: FadeTransition(
            opacity: _fadeAnimation,
            child: BottomNavigation(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });

                _navigateToView(index);
              },
            ),
          ),
        );
      },
    );
  }

  void _navigateToView(int index) {
    switch (index) {
      case 0: // الملف الشخصي
        Navigator.pushNamed(context, Routes.profileView);
        break;
      case 1: // السلة
        Navigator.pushNamed(context, Routes.cartView);
        break;
      case 2: // المفضلة
        _showComingSoonDialog('صفحة المفضلة');
        break;
      case 3: // الرئيسية
        // Already on home view, do nothing
        break;
    }
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

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'اختيار الموقع',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ),
          ),
        ),
        content: Text(
          'اختر موقع التوصيل',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'البحث',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ),
          ),
        ),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن المنتجات...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('بحث'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تصفية المنتجات',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ),
          ),
        ),
        content: Text(
          'خيارات التصفية',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تطبيق'),
          ),
        ],
      ),
    );
  }

  void _showBannerDialog(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم النقر على البانر $index'),
        backgroundColor: ColorsManager.kPrimaryColor,
      ),
    );
  }

  void _showComingSoonDialog(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature قيد التطوير'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
