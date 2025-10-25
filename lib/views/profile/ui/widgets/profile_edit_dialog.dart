import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class ProfileEditDialog {
  static void show(
    BuildContext context,
    String title,
    String currentValue,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyles(context).font18PrimaryBold),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'أدخل $title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyles(context).font14PrimaryRegular,
            ),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: Text('حفظ', style: TextStyles(context).font14PrimaryBold),
          ),
        ],
      ),
    );
  }
}
