import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveHelper {
  /// Get responsive width based on screen width
  static double getResponsiveWidth(BuildContext context, double width) {
    return width.w;
  }

  /// Get responsive height based on screen height
  static double getResponsiveHeight(BuildContext context, double height) {
    return height.h;
  }

  /// Get responsive font size
  static double getResponsiveFontSize(double fontSize) {
    return fontSize.sp;
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    if (all != null) {
      return EdgeInsets.all(all.w);
    }
    return EdgeInsets.only(
      left: left?.w ?? 0,
      right: right?.w ?? 0,
      top: top?.h ?? 0,
      bottom: bottom?.h ?? 0,
    );
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    if (all != null) {
      return EdgeInsets.all(all.w);
    }
    return EdgeInsets.only(
      left: left?.w ?? 0,
      right: right?.w ?? 0,
      top: top?.h ?? 0,
      bottom: bottom?.h ?? 0,
    );
  }

  /// Get responsive border radius
  static BorderRadius getResponsiveBorderRadius(double radius) {
    return BorderRadius.circular(radius.r);
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768;
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(double size) {
    return size.sp;
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(double spacing) {
    return spacing.h;
  }

  /// Get responsive screen width percentage
  static double getScreenWidthPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.of(context).size.width * percentage;
  }

  /// Get responsive screen height percentage
  static double getScreenHeightPercentage(
    BuildContext context,
    double percentage,
  ) {
    return MediaQuery.of(context).size.height * percentage;
  }
}
