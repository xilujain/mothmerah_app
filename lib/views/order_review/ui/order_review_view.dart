import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/views/order_review/ui/logic/cubit/order_review_cubit.dart';
import 'package:mothmerah_app/views/order_review/ui/logic/cubit/order_review_state.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/delivery_details_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/payment_details_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/promotional_code_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/order_summary_section.dart';
import 'package:mothmerah_app/views/order_review/ui/widgets/pay_button.dart';

class OrderReviewView extends StatefulWidget {
  const OrderReviewView({super.key});

  @override
  State<OrderReviewView> createState() => _OrderReviewViewState();
}

class _OrderReviewViewState extends State<OrderReviewView> {
  late OrderReviewCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = OrderReviewCubit();
    _cubit.loadOrderData();
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
      child: Scaffold(
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
            style: TextStyles(context).font18BlackBold,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.kPrimaryColor,
              ),
              onPressed: () {
                // Handle next action
              },
            ),
          ],
        ),
        body: BlocBuilder<OrderReviewCubit, OrderReviewState>(
          builder: (context, state) {
            return ScrollableWrapper(
              child: Column(
                children: [
                  // Delivery Details Section
                  DeliveryDetailsSection(
                    deliveryTime: state.deliveryTime,
                    address: state.address,
                    onLocationChange: () {
                      // Handle location change
                    },
                    onInstructionsChange: (instructions) {
                      _cubit.updateDeliveryInstructions(instructions);
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Payment Details Section
                  PaymentDetailsSection(
                    paymentMethod: state.paymentMethod,
                    onPaymentChange: () {
                      // Handle payment method change
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Promotional Code Section
                  PromotionalCodeSection(
                    onCodeApplied: (code) {
                      _cubit.applyPromotionalCode(code);
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Order Summary Section
                  OrderSummarySection(
                    orderTotal: state.orderTotal,
                    deliveryFee: state.deliveryFee,
                    total: state.total,
                  ),

                  SizedBox(height: 100.h), // Space for pay button
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: PayButton(
          total: _cubit.state.total,
          onPay: () {
            // Navigate to payment success or handle payment
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.homeView,
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
