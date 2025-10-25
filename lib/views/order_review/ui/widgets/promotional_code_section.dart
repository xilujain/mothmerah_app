import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class PromotionalCodeSection extends StatelessWidget {
  final Function(String) onCodeApplied;

  const PromotionalCodeSection({super.key, required this.onCodeApplied});

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الرمز الترويجي', style: textStyles.font16PrimaryBold),
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                hintText: 'هل لديك رمز ترويجي ؟',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.check, color: ColorsManager.kPrimaryColor),
                  onPressed: () {
                    // Apply code
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
