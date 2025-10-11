import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';

import '../theme/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool hasCircularBorder;
  final double width;
  final double height;
  final double borderRadius;
  final Color color;
  final Color colortext;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? icon;
  const MainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.hasCircularBorder = false,
    this.color = ColorsManager.kPrimaryColor,
    this.colortext = Colors.white,
    this.width = double.infinity,
    this.height = 50,
    this.fontSize = 20,
    this.borderRadius = 10,
    this.fontWeight = FontWeight.w600,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        child: MaterialButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Text(
                text,
                style: TextStyles(context).font16PrimaryMedium.copyWith(
                  color: colortext,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
