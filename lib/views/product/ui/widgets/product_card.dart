import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _scaleController.forward();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _scaleController.reverse();
          widget.onTap();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _scaleController.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.getBorderRadius(
                  context,
                  mobile: 16,
                  tablet: 20,
                  desktop: 24,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 12.0,
                    tablet: 16.0,
                    desktop: 20.0,
                  ),
                  offset: const Offset(0, 4),
                ),
                if (_isPressed)
                  BoxShadow(
                    color: ColorsManager.kPrimaryColor.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  flex: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 3,
                    tablet: 4,
                    desktop: 5,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorsManager.kLightGray,
                              ColorsManager.kLightGray.withValues(alpha: 0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              ResponsiveHelper.getBorderRadius(
                                context,
                                mobile: 16,
                                tablet: 20,
                                desktop: 24,
                              ),
                            ),
                            topRight: Radius.circular(
                              ResponsiveHelper.getBorderRadius(
                                context,
                                mobile: 16,
                                tablet: 20,
                                desktop: 24,
                              ),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Hero(
                            tag: 'product_image_${widget.product.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  ResponsiveHelper.getBorderRadius(
                                    context,
                                    mobile: 16,
                                    tablet: 20,
                                    desktop: 24,
                                  ),
                                ),
                                topRight: Radius.circular(
                                  ResponsiveHelper.getBorderRadius(
                                    context,
                                    mobile: 16,
                                    tablet: 20,
                                    desktop: 24,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                widget.product.imageUrl,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.image,
                                      size: ResponsiveHelper.getIconSize(
                                        context,
                                        mobile: 60,
                                        tablet: 80,
                                        desktop: 100,
                                      ),
                                      color: ColorsManager.kPrimaryColor
                                          .withValues(alpha: 0.6),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Limited quantity badge
                      if (widget.product.isLimited)
                        Positioned(
                          top: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 8,
                            tablet: 12,
                            desktop: 16,
                          ),
                          right: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 8,
                            tablet: 12,
                            desktop: 16,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 8,
                                tablet: 12,
                                desktop: 16,
                              ),
                              vertical: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 4,
                                tablet: 6,
                                desktop: 8,
                              ),
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorsManager.kPrimaryColor,
                                  ColorsManager.kPrimaryColor.withValues(
                                    alpha: 0.8,
                                  ),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.getBorderRadius(
                                  context,
                                  mobile: 12,
                                  tablet: 16,
                                  desktop: 20,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsManager.kPrimaryColor.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'كمية محدودة',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(
                                  context,
                                  mobile: 10,
                                  tablet: 12,
                                  desktop: 14,
                                ),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      // Local product badge
                      if (widget.product.isLocal)
                        Positioned(
                          top: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 8,
                            tablet: 12,
                            desktop: 16,
                          ),
                          left: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 8,
                            tablet: 12,
                            desktop: 16,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 6,
                                tablet: 8,
                                desktop: 10,
                              ),
                              vertical: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 3,
                                tablet: 4,
                                desktop: 5,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.getBorderRadius(
                                  context,
                                  mobile: 8,
                                  tablet: 10,
                                  desktop: 12,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.home,
                                  size: ResponsiveHelper.getIconSize(
                                    context,
                                    mobile: 12,
                                    tablet: 14,
                                    desktop: 16,
                                  ),
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: ResponsiveHelper.getSpacing(
                                    context,
                                    mobile: 2,
                                    tablet: 3,
                                    desktop: 4,
                                  ),
                                ),
                                Text(
                                  'محلي',
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.getFontSize(
                                      context,
                                      mobile: 8,
                                      tablet: 10,
                                      desktop: 12,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Add to cart button
                      Positioned(
                        bottom: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 8,
                          tablet: 12,
                          desktop: 16,
                        ),
                        left: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 8,
                          tablet: 12,
                          desktop: 16,
                        ),
                        child: GestureDetector(
                          onTap: widget.onAddToCart,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: ResponsiveHelper.getResponsiveValue(
                              context,
                              mobile: 36.0,
                              tablet: 42.0,
                              desktop: 48.0,
                            ),
                            height: ResponsiveHelper.getResponsiveValue(
                              context,
                              mobile: 36.0,
                              tablet: 42.0,
                              desktop: 48.0,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.grey[50]!],
                              ),
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.getBorderRadius(
                                  context,
                                  mobile: 10,
                                  tablet: 12,
                                  desktop: 14,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add,
                              color: ColorsManager.kPrimaryColor,
                              size: ResponsiveHelper.getIconSize(
                                context,
                                mobile: 20,
                                tablet: 24,
                                desktop: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Product Info
                Expanded(
                  flex: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 2,
                    tablet: 2,
                    desktop: 2,
                  ),
                  child: Padding(
                    padding: ResponsiveHelper.getPadding(
                      context,
                      mobile: 12,
                      tablet: 16,
                      desktop: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 8,
                              tablet: 10,
                              desktop: 12,
                            ),
                            vertical: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 4,
                              tablet: 6,
                              desktop: 8,
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorsManager.kPrimaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                ColorsManager.kPrimaryColor.withValues(
                                  alpha: 0.05,
                                ),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.getBorderRadius(
                                context,
                                mobile: 8,
                                tablet: 10,
                                desktop: 12,
                              ),
                            ),
                          ),
                          child: Text(
                            '${widget.product.price.toInt()} ﷼',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getFontSize(
                                context,
                                mobile: 14,
                                tablet: 16,
                                desktop: 18,
                              ),
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.kPrimaryColor,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 6,
                            tablet: 8,
                            desktop: 10,
                          ),
                        ),

                        // Product Name
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context,
                              mobile: 14,
                              tablet: 16,
                              desktop: 18,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 4,
                            tablet: 6,
                            desktop: 8,
                          ),
                        ),

                        // Product Weight and Calories
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.weight,
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.getFontSize(
                                    context,
                                    mobile: 12,
                                    tablet: 14,
                                    desktop: 16,
                                  ),
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.product.calories > 0) ...[
                              SizedBox(
                                width: ResponsiveHelper.getSpacing(
                                  context,
                                  mobile: 4,
                                  tablet: 6,
                                  desktop: 8,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveHelper.getSpacing(
                                    context,
                                    mobile: 6,
                                    tablet: 8,
                                    desktop: 10,
                                  ),
                                  vertical: ResponsiveHelper.getSpacing(
                                    context,
                                    mobile: 2,
                                    tablet: 3,
                                    desktop: 4,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveHelper.getBorderRadius(
                                      context,
                                      mobile: 6,
                                      tablet: 8,
                                      desktop: 10,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '${widget.product.calories} سعرة',
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.getFontSize(
                                      context,
                                      mobile: 10,
                                      tablet: 12,
                                      desktop: 14,
                                    ),
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
