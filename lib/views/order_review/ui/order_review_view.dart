import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/order_review/ui/logic/cubit/order_review_cubit.dart';
import 'package:mothmerah_app/views/order_review/ui/logic/cubit/order_review_state.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/delivery_details_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/payment_details_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/promotional_code_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/order_summary_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/pay_button.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_cubit.dart';
import 'package:mothmerah_app/views/cart/ui/logic/cubit/cart_state.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';

class OrderReviewView extends StatefulWidget {
  const OrderReviewView({super.key});

  @override
  State<OrderReviewView> createState() => _OrderReviewViewState();
}

class _OrderReviewViewState extends State<OrderReviewView>
    with TickerProviderStateMixin {
  late OrderReviewCubit _cubit;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _cubit = OrderReviewCubit();
    _cubit.loadOrderData();

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
        listener: (context, cartState) {
          // Update order review when cart changes
          if (cartState is CartLoaded) {
            _cubit.updateCartData(cartState.items, cartState.totalAmount);
          }
        },
        builder: (context, cartState) {
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'مراجعة الطلب',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 18,
                    tablet: 20,
                    desktop: 22,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<OrderReviewCubit, OrderReviewState>(
              builder: (context, state) {
                if (cartState is CartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorsManager.kPrimaryColor,
                      ),
                    ),
                  );
                }

                if (cartState is CartError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: ResponsiveHelper.getIconSize(
                            context,
                            mobile: 64,
                            tablet: 80,
                            desktop: 96,
                          ),
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 16,
                            tablet: 20,
                            desktop: 24,
                          ),
                        ),
                        Text(
                          'خطأ في تحميل بيانات السلة',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context,
                              mobile: 18,
                              tablet: 20,
                              desktop: 22,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 8,
                            tablet: 10,
                            desktop: 12,
                          ),
                        ),
                        Text(
                          cartState.error,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context,
                              mobile: 14,
                              tablet: 16,
                              desktop: 18,
                            ),
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 24,
                            tablet: 28,
                            desktop: 32,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CartCubit>().loadCart();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.kPrimaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 24,
                                tablet: 28,
                                desktop: 32,
                              ),
                              vertical: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 12,
                                tablet: 14,
                                desktop: 16,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.getBorderRadius(
                                  context,
                                  mobile: 12,
                                  tablet: 14,
                                  desktop: 16,
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'إعادة المحاولة',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getFontSize(
                                context,
                                mobile: 14,
                                tablet: 16,
                                desktop: 18,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final cartItems = cartState is CartLoaded
                    ? cartState.items
                    : <ProductModel>[];
                final cartTotal = cartState is CartLoaded
                    ? cartState.totalAmount
                    : 0.0;

                if (cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: ResponsiveHelper.getIconSize(
                            context,
                            mobile: 80,
                            tablet: 100,
                            desktop: 120,
                          ),
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 16,
                            tablet: 20,
                            desktop: 24,
                          ),
                        ),
                        Text(
                          'السلة فارغة',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context,
                              mobile: 20,
                              tablet: 24,
                              desktop: 28,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 8,
                            tablet: 10,
                            desktop: 12,
                          ),
                        ),
                        Text(
                          'أضف منتجات إلى السلة أولاً',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context,
                              mobile: 14,
                              tablet: 16,
                              desktop: 18,
                            ),
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(
                          height: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 24,
                            tablet: 28,
                            desktop: 32,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.homeView,
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.kPrimaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 24,
                                tablet: 28,
                                desktop: 32,
                              ),
                              vertical: ResponsiveHelper.getSpacing(
                                context,
                                mobile: 12,
                                tablet: 14,
                                desktop: 16,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.getBorderRadius(
                                  context,
                                  mobile: 12,
                                  tablet: 14,
                                  desktop: 16,
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'تسوق الآن',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getFontSize(
                                context,
                                mobile: 14,
                                tablet: 16,
                                desktop: 18,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScrollableWrapper(
                      child: Column(
                        children: [
                          // Cart Items Summary
                          _buildCartItemsSummary(cartItems),

                          SizedBox(
                            height: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 16,
                              tablet: 20,
                              desktop: 24,
                            ),
                          ),

                          // Delivery Details Section
                          DeliveryDetailsSection(
                            deliveryTime: state.deliveryTime,
                            address: state.address,
                            onLocationChange: () {
                              _showLocationDialog();
                            },
                            onInstructionsChange: (instructions) {
                              _cubit.updateDeliveryInstructions(instructions);
                            },
                          ),

                          SizedBox(
                            height: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 16,
                              tablet: 20,
                              desktop: 24,
                            ),
                          ),

                          // Payment Details Section
                          PaymentDetailsSection(
                            paymentMethod: state.paymentMethod,
                            onPaymentChange: () {
                              _showPaymentDialog();
                            },
                          ),

                          SizedBox(
                            height: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 16,
                              tablet: 20,
                              desktop: 24,
                            ),
                          ),

                          // Promotional Code Section
                          PromotionalCodeSection(
                            onCodeApplied: (code) {
                              _cubit.applyPromotionalCode(code);
                            },
                          ),

                          SizedBox(
                            height: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 16,
                              tablet: 20,
                              desktop: 24,
                            ),
                          ),

                          // Order Summary Section
                          OrderSummarySection(
                            orderTotal: cartTotal,
                            deliveryFee: state.deliveryFee,
                            total: cartTotal + state.deliveryFee,
                          ),

                          SizedBox(
                            height: ResponsiveHelper.getSpacing(
                              context,
                              mobile: 100,
                              tablet: 120,
                              desktop: 140,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar:
                BlocBuilder<OrderReviewCubit, OrderReviewState>(
                  builder: (context, orderState) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: PayButton(
                        total: cartState is CartLoaded
                            ? cartState.totalAmount + orderState.deliveryFee
                            : orderState.total,
                        onPay: () {
                          _handlePayment();
                        },
                      ),
                    );
                  },
                ),
          );
        },
      ),
    );
  }

  Widget _buildCartItemsSummary(List<ProductModel> cartItems) {
    return Container(
      margin: ResponsiveHelper.getHorizontalPadding(
        context,
        mobile: 16,
        tablet: 20,
        desktop: 24,
      ),
      padding: ResponsiveHelper.getPadding(
        context,
        mobile: 16,
        tablet: 20,
        desktop: 24,
      ),
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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shopping_cart,
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
              Text(
                'منتجات السلة (${cartItems.length})',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 16,
                    tablet: 18,
                    desktop: 20,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 12,
              tablet: 14,
              desktop: 16,
            ),
          ),
          ...cartItems
              .take(3)
              .map(
                (item) => Padding(
                  padding: EdgeInsets.only(
                    bottom: ResponsiveHelper.getSpacing(
                      context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ResponsiveHelper.getResponsiveValue(
                          context,
                          mobile: 40.0,
                          tablet: 48.0,
                          desktop: 56.0,
                        ),
                        height: ResponsiveHelper.getResponsiveValue(
                          context,
                          mobile: 40.0,
                          tablet: 48.0,
                          desktop: 56.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.getBorderRadius(
                              context,
                              mobile: 8,
                              tablet: 10,
                              desktop: 12,
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[400],
                          size: ResponsiveHelper.getIconSize(
                            context,
                            mobile: 20,
                            tablet: 24,
                            desktop: 28,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 12,
                          tablet: 14,
                          desktop: 16,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(
                                  context,
                                  mobile: 14,
                                  tablet: 16,
                                  desktop: 18,
                                ),
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${item.price.toInt()} ر.س',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(
                                  context,
                                  mobile: 12,
                                  tablet: 14,
                                  desktop: 16,
                                ),
                                color: ColorsManager.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          if (cartItems.length > 3)
            Padding(
              padding: EdgeInsets.only(
                top: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 8,
                  tablet: 10,
                  desktop: 12,
                ),
              ),
              child: Text(
                'و ${cartItems.length - 3} منتج آخر...',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handlePayment() {
    // Show payment processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorsManager.kPrimaryColor,
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.getSpacing(
                context,
                mobile: 16,
                tablet: 20,
                desktop: 24,
              ),
            ),
            Text(
              'جاري معالجة الدفع...',
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      _showPaymentSuccessDialog();
    });
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              'تم الدفع بنجاح',
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 18,
                  tablet: 20,
                  desktop: 22,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'تم تأكيد طلبك وسيتم التوصيل خلال 30-45 دقيقة',
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
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.homeView,
                (route) => false,
              );
            },
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تغيير الموقع',
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
          'اختر موقع التوصيل الجديد',
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
            onPressed: () {
              Navigator.pop(context);
              _cubit.updateAddress('الموقع الجديد');
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'طرق الدفع',
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
          'اختر طريقة الدفع المفضلة',
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
            onPressed: () {
              Navigator.pop(context);
              _cubit.updatePaymentMethod('Apple Pay');
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}
