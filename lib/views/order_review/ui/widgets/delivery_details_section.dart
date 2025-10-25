import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class DeliveryDetailsSection extends StatelessWidget {
  final String deliveryTime;
  final String address;
  final VoidCallback onLocationChange;
  final Function(String) onInstructionsChange;

  const DeliveryDetailsSection({
    super.key,
    required this.deliveryTime,
    required this.address,
    required this.onLocationChange,
    required this.onInstructionsChange,
  });

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
            color: Colors.black.withOpacity(0.05),
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
            // Section title
            Text('تفاصيل التوصيل', style: textStyles.font16PrimaryBold),

            SizedBox(height: 16.h),

            // Expected time
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: ColorsManager.kPrimaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text('الوقت المتوقع', style: textStyles.font14BlackBold),
                  const Spacer(),
                  Text(deliveryTime, style: textStyles.font14PrimaryBold),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Map and address
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Stack(
                children: [
                  // Dummy map
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 40.sp, color: Colors.grey[600]),
                          SizedBox(height: 8.h),
                          Text(
                            'خريطة الموقع',
                            style: textStyles.font12GrayRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Location pin
                  Positioned(
                    top: 40.h,
                    left: 60.w,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Address
            Row(
              children: [
                Expanded(
                  child: Text(address, style: textStyles.font14PrimaryRegular),
                ),
                TextButton(
                  onPressed: onLocationChange,
                  child: Text('تغيير', style: textStyles.font14PrimaryBold),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Delivery instructions
            Text('تعليمات التوصيل', style: textStyles.font16PrimaryBold),

            SizedBox(height: 8.h),

            // Instructions input
            GestureDetector(
              onTap: () {
                _showInstructionsDialog(context);
              },
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: ColorsManager.kPrimaryColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'اضف ملاحظات أو رقم اتصال أو صورة',
                        style: textStyles.font14GrayRegular,
                      ),
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey[400],
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInstructionsDialog(BuildContext context) {
    final textStyles = TextStyles(context);
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعليمات التوصيل', style: textStyles.font18BlackBold),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'أدخل تعليمات التوصيل...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              onInstructionsChange(controller.text);
              Navigator.pop(context);
            },
            child: Text('حفظ'),
          ),
        ],
      ),
    );
  }
}
