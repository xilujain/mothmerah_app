import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'package:mothmerah_app/views/order/ui/logic/cubit/order_cubit.dart';
import 'package:mothmerah_app/views/order/ui/logic/cubit/order_state.dart';

class OrderConfirmationDialog extends StatefulWidget {
  final double totalAmount;
  final String currencyCode;
  final List<ProductModel> cartItems;
  final VoidCallback onOrderConfirmed;

  const OrderConfirmationDialog({
    super.key,
    required this.totalAmount,
    required this.currencyCode,
    required this.cartItems,
    required this.onOrderConfirmed,
  });

  @override
  State<OrderConfirmationDialog> createState() => _OrderConfirmationDialogState();
}

class _OrderConfirmationDialogState extends State<OrderConfirmationDialog> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          Navigator.of(context).pop(); // Close dialog
          widget.onOrderConfirmed();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم إنشاء الطلب بنجاح! رقم الطلب: ${state.orderResponse.orderId}'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ في إنشاء الطلب: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_checkout,
                    color: ColorsManager.kPrimaryColor,
                    size: 24.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'تأكيد الطلب',
                    style: textStyles.font18PrimaryBold,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              
              SizedBox(height: 16.h),
              
              // Order Summary
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المبلغ الإجمالي:',
                          style: textStyles.font14BlackBold,
                        ),
                        Text(
                          '${widget.totalAmount.toStringAsFixed(2)} ${widget.currencyCode}',
                          style: textStyles.font16PrimaryBold,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ضريبة القيمة المضافة (15%):',
                          style: textStyles.font14GrayRegular,
                        ),
                        Text(
                          '${(widget.totalAmount * 0.15).toStringAsFixed(2)} ${widget.currencyCode}',
                          style: textStyles.font14GrayRegular,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المبلغ النهائي:',
                          style: textStyles.font18BlackBold,
                        ),
                        Text(
                          '${(widget.totalAmount * 1.15).toStringAsFixed(2)} ${widget.currencyCode}',
                          style: textStyles.font18PrimaryBold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Notes field
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'ملاحظات إضافية (اختياري)',
                  labelStyle: textStyles.font14GrayRegular,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: ColorsManager.kPrimaryColor),
                  ),
                ),
                maxLines: 3,
              ),
              
              SizedBox(height: 20.h),
              
              // Action buttons
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  final isLoading = state is OrderLoading;
                  
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'إلغاء',
                            style: textStyles.font14BlackBold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () {
                            context.read<OrderCubit>().createOrder(
                              cartItems: widget.cartItems,
                              totalAmount: widget.totalAmount,
                              notesFromBuyer: _notesController.text.trim(),
                              currencyCode: widget.currencyCode,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.kPrimaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'تأكيد الطلب',
                                  style: textStyles.font16WhiteBold,
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
