import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';

class ProductDetailHeader extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onShareTap;
  final VoidCallback onFullScreenTap;

  const ProductDetailHeader({
    super.key,
    required this.onBackTap,
    required this.onShareTap,
    required this.onFullScreenTap,
  });

  @override
  Widget build(BuildContext context) {
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
          const Spacer(),
          IconButton(
            onPressed: onShareTap,
            icon: Icon(
              Icons.share_outlined,
              color: ColorsManager.kPrimaryColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: onFullScreenTap,
            icon: Icon(
              Icons.fullscreen_outlined,
              color: ColorsManager.kPrimaryColor,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
