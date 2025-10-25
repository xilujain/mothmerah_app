import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class ProductInfoSection extends StatefulWidget {
  final ProductModel product;
  final int quantity;
  final Function(int) onQuantityChanged;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product name and price with animation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorsManager.kPrimaryColor,
                          ColorsManager.kPrimaryColor.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${widget.product.price.toStringAsFixed(0)} ر.س',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Tags row with animation
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  if (widget.product.isLocal) ...[
                    _buildAnimatedTag('إنتاج محلي', Colors.green, Icons.home),
                  ],
                  if (widget.product.isLimited) ...[
                    _buildAnimatedTag(
                      'كمية محدودة',
                      ColorsManager.kPrimaryColor,
                      Icons.warning,
                    ),
                  ],
                ],
              ),

              SizedBox(height: 16.h),

              // Calories tag with animation
              _buildAnimatedTag(
                '${widget.product.calories} سعرة حرارية',
                Colors.orange,
                Icons.local_fire_department,
                isLarge: true,
              ),

              SizedBox(height: 20.h),

              // Quantity selector with animation
              Row(
                children: [
                  Text(
                    'الكمية:',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  _buildQuantitySelector(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTag(
    String text,
    Color color,
    IconData icon, {
    bool isLarge = false,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isLarge ? 16.w : 12.w,
              vertical: isLarge ? 10.h : 8.h,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(isLarge ? 16.r : 12.r),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: isLarge ? 18.sp : 16.sp),
                SizedBox(width: 6.w),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: isLarge ? 14.sp : 12.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            icon: Icons.remove,
            onPressed: widget.quantity > 1
                ? () => widget.onQuantityChanged(widget.quantity - 1)
                : null,
            isEnabled: widget.quantity > 1,
          ),
          Container(
            width: 50.w,
            height: 40.h,
            alignment: Alignment.center,
            child: Text(
              widget.quantity.toString(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          _buildQuantityButton(
            icon: Icons.add,
            onPressed: () => widget.onQuantityChanged(widget.quantity + 1),
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: isEnabled ? ColorsManager.kPrimaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: isEnabled ? Colors.white : Colors.grey[500],
          size: 18.sp,
        ),
      ),
    );
  }
}
