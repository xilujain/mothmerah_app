import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class ProductImageSection extends StatefulWidget {
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
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dummy images for the product
    final List<String> productImages = [
      widget.product.imageUrl,
      'assets/images/chili_2.jpg',
      'assets/images/chili_3.jpg',
      'assets/images/chili_4.jpg',
      'assets/images/chili_5.jpg',
    ];

    return SizedBox(
      height: 350.h,
      child: Stack(
        children: [
          // Main product image with animation
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 280.w,
                  height: 280.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: ColorsManager.kPrimaryColor.withValues(alpha: 0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Hero(
                      tag: 'product_${widget.product.id}',
                      child: Image.asset(
                        productImages[widget.currentImageIndex],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorsManager.kPrimaryColor.withValues(alpha: 0.1),
                                  ColorsManager.kPrimaryColor.withValues(alpha: 0.05),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 60.sp,
                                    color: ColorsManager.kPrimaryColor
                                        .withValues(alpha: 0.5),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'صورة المنتج',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorsManager.kPrimaryColor
                                          .withValues(alpha: 0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Action buttons with animation
          Positioned(
            left: 20.w,
            top: 20.h,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _fadeController,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                child: _buildActionButton(
                  icon: Icons.zoom_out_map,
                  onTap: () {
                    // Handle zoom
                    _showZoomDialog();
                  },
                ),
              ),
            ),
          ),

          Positioned(
            left: 20.w,
            top: 80.h,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _fadeController,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                child: _buildActionButton(
                  icon: Icons.share,
                  onTap: () {
                    // Handle share
                    _showShareDialog();
                  },
                ),
              ),
            ),
          ),

          // Image indicators with animation
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  productImages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: index == widget.currentImageIndex ? 24.w : 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: index == widget.currentImageIndex
                          ? ColorsManager.kPrimaryColor
                          : Colors.grey[300],
                    ),
                    child: GestureDetector(
                      onTap: () => widget.onImageChanged(index),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: index == widget.currentImageIndex
                              ? ColorsManager.kPrimaryColor
                              : Colors.grey[300],
                        ),
                      ),
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

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: ColorsManager.kPrimaryColor, size: 22.sp),
      ),
    );
  }

  void _showZoomDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: 400.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تكبير الصورة',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    widget.product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image,
                          size: 60.sp,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'مشاركة المنتج',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل تريد مشاركة ${widget.product.name}؟',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('تم نسخ رابط المنتج'),
                  backgroundColor: ColorsManager.kPrimaryColor,
                ),
              );
            },
            child: const Text('مشاركة'),
          ),
        ],
      ),
    );
  }
}
