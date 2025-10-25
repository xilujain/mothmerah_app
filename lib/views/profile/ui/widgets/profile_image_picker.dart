import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class ProfileImagePicker {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: ColorsManager.kPrimaryColor,
              ),
              title: Text(
                'التقاط صورة',
                style: TextStyles(context).font16PrimaryRegular,
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle camera
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: ColorsManager.kPrimaryColor,
              ),
              title: Text(
                'اختيار من المعرض',
                style: TextStyles(context).font16PrimaryRegular,
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle gallery
              },
            ),
          ],
        ),
      ),
    );
  }
}
