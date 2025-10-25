import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class CartHeader extends StatelessWidget {
  final VoidCallback onBackTap;

  const CartHeader({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackTap,
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorsManager.kPrimaryColor,
              size: 24.sp,
            ),
          ),
          Expanded(
            child: Text(
              'السلة',
              textAlign: TextAlign.center,
              style: textStyles.font20PrimaryBold,
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle close
            },
            icon: Icon(
              Icons.close,
              color: ColorsManager.kPrimaryColor,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}

