import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/product/data/product_model.dart';
import 'package:mothmerah_app/views/product_detail/ui/widgets/quantity_selector.dart';

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final VoidCallback onAddToCart;

  const AddToCartButton({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);
    final totalPrice = product.price * quantity;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.green[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Quantity selector
          QuantitySelector(
            quantity: quantity,
            onQuantityChanged: (newQuantity) {
              // This will be handled by the parent widget
            },
          ),

          SizedBox(width: 16.w),

          // Cart icon with badge
          Stack(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: ColorsManager.kPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: ColorsManager.kPrimaryColor,
                  size: 20.sp,
                ),
              ),
              if (quantity > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        quantity.toString(),
                        style: textStyles.font10WhiteBold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: 16.w),

          // Total price
          Text(
            '${totalPrice.toStringAsFixed(0)} ر.س',
            style: textStyles.font16PrimaryBold,
          ),

          const Spacer(),

          // Add to cart button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.kPrimaryColor,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('أضف إلى السلة', style: textStyles.font16WhiteBold),
            ),
          ),
        ],
      ),
    );
  }
}
