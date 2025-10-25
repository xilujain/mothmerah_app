import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorsManager.kPrimaryColor
                      : ColorsManager.kLightGray,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: textStyles.font14PrimaryBold.copyWith(
                      color: isSelected
                          ? Colors.white
                          : ColorsManager.kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

