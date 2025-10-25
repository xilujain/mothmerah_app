import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';

class HomeHeader extends StatefulWidget {
  final VoidCallback onLocationTap;
  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  const HomeHeader({
    super.key,
    required this.onLocationTap,
    required this.onSearchTap,
    required this.onFilterTap,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: ResponsiveHelper.getPadding(
            context,
            mobile: 16,
            tablet: 20,
            desktop: 24,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Top row with location and search
              Row(
                children: [
                  // Location
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onLocationTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 12,
                            tablet: 16,
                            desktop: 20,
                          ),
                          vertical: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 10,
                            tablet: 12,
                            desktop: 14,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.getBorderRadius(
                              context,
                              mobile: 12,
                              tablet: 16,
                              desktop: 20,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: ColorsManager.kPrimaryColor,
                              size: ResponsiveHelper.getIconSize(
                                context,
                                mobile: 20,
                                tablet: 24,
                                desktop: 28,
                              ),
                            ),
                            SizedBox(
                              width: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 8,
                                tablet: 10,
                                desktop: 12,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'التوصيل إلى',
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
                                  ),
                                  Text(
                                    'الرياض، المملكة العربية السعودية',
                                    style: TextStyle(
                                      fontSize: ResponsiveHelper.getFontSize(
                                        context,
                                        mobile: 14,
                                        tablet: 16,
                                        desktop: 18,
                                      ),
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[600],
                              size: ResponsiveHelper.getIconSize(
                                context,
                                mobile: 20,
                                tablet: 24,
                                desktop: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: ResponsiveHelper.getSpacing(
                      context,
                      mobile: 12,
                      tablet: 16,
                      desktop: 20,
                    ),
                  ),

                  // Search button
                  GestureDetector(
                    onTap: widget.onSearchTap,
                    child: Container(
                      width: ResponsiveHelper.getResponsiveValue(
                        context,
                        mobile: 48.0,
                        tablet: 56.0,
                        desktop: 64.0,
                      ),
                      height: ResponsiveHelper.getResponsiveValue(
                        context,
                        mobile: 48.0,
                        tablet: 56.0,
                        desktop: 64.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorsManager.kPrimaryColor,
                            ColorsManager.kPrimaryColor.withValues(alpha: 0.8),
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
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: ResponsiveHelper.getIconSize(
                          context,
                          mobile: 24,
                          tablet: 28,
                          desktop: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 16,
                  tablet: 20,
                  desktop: 24,
                ),
              ),

              // Bottom row with filter and title
              Row(
                children: [
                  // Filter button
                  GestureDetector(
                    onTap: widget.onFilterTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 12,
                          tablet: 16,
                          desktop: 20,
                        ),
                        vertical: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 8,
                          tablet: 10,
                          desktop: 12,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.getBorderRadius(
                            context,
                            mobile: 10,
                            tablet: 12,
                            desktop: 14,
                          ),
                        ),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.tune,
                            color: Colors.grey[700],
                            size: ResponsiveHelper.getIconSize(
                              context,
                              mobile: 18,
                              tablet: 20,
                              desktop: 22,
                            ),
                          ),
                          SizedBox(
                            width: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 4,
                              tablet: 6,
                              desktop: 8,
                            ),
                          ),
                          Text(
                            'تصفية',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getFontSize(
                                context,
                                mobile: 12,
                                tablet: 14,
                                desktop: 16,
                              ),
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: ResponsiveHelper.getSpacing(
                      context,
                      mobile: 16,
                      tablet: 20,
                      desktop: 24,
                    ),
                  ),

                  // Title
                  Expanded(
                    child: Text(
                      'منتجات طازجة',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 20,
                          tablet: 24,
                          desktop: 28,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
