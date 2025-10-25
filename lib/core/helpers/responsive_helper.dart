import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveHelper {
  // Screen breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Get screen type
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) {
      return ScreenType.mobile;
    } else if (width < tabletBreakpoint) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  // Responsive padding
  static EdgeInsets getPadding(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    double padding;
    
    switch (screenType) {
      case ScreenType.mobile:
        padding = mobile ?? 16.w;
        break;
      case ScreenType.tablet:
        padding = tablet ?? 24.w;
        break;
      case ScreenType.desktop:
        padding = desktop ?? 32.w;
        break;
    }
    
    return EdgeInsets.all(padding);
  }

  // Responsive horizontal padding
  static EdgeInsets getHorizontalPadding(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    double padding;
    
    switch (screenType) {
      case ScreenType.mobile:
        padding = mobile ?? 16.w;
        break;
      case ScreenType.tablet:
        padding = tablet ?? 24.w;
        break;
      case ScreenType.desktop:
        padding = desktop ?? 32.w;
        break;
    }
    
    return EdgeInsets.symmetric(horizontal: padding);
  }

  // Responsive vertical padding
  static EdgeInsets getVerticalPadding(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    double padding;
    
    switch (screenType) {
      case ScreenType.mobile:
        padding = mobile ?? 16.h;
        break;
      case ScreenType.tablet:
        padding = tablet ?? 20.h;
        break;
      case ScreenType.desktop:
        padding = desktop ?? 24.h;
        break;
    }
    
    return EdgeInsets.symmetric(vertical: padding);
  }

  // Responsive font size
  static double getFontSize(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return (mobile ?? 14).sp;
      case ScreenType.tablet:
        return (tablet ?? 16).sp;
      case ScreenType.desktop:
        return (desktop ?? 18).sp;
    }
  }

  // Responsive spacing
  static double getSpacing(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return (mobile ?? 8).h;
      case ScreenType.tablet:
        return (tablet ?? 12).h;
      case ScreenType.desktop:
        return (desktop ?? 16).h;
    }
  }

  // Responsive grid columns
  static int getGridColumns(BuildContext context, {
    int? mobile,
    int? tablet,
    int? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return mobile ?? 2;
      case ScreenType.tablet:
        return tablet ?? 3;
      case ScreenType.desktop:
        return desktop ?? 4;
    }
  }

  // Responsive container width
  static double getContainerWidth(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    switch (screenType) {
      case ScreenType.mobile:
        return mobile ?? screenWidth;
      case ScreenType.tablet:
        return tablet ?? screenWidth * 0.8;
      case ScreenType.desktop:
        return desktop ?? screenWidth * 0.6;
    }
  }

  // Responsive border radius
  static double getBorderRadius(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return (mobile ?? 12).r;
      case ScreenType.tablet:
        return (tablet ?? 16).r;
      case ScreenType.desktop:
        return (desktop ?? 20).r;
    }
  }

  // Responsive icon size
  static double getIconSize(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return (mobile ?? 24).sp;
      case ScreenType.tablet:
        return (tablet ?? 28).sp;
      case ScreenType.desktop:
        return (desktop ?? 32).sp;
    }
  }

  // Responsive button height
  static double getButtonHeight(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return (mobile ?? 48).h;
      case ScreenType.tablet:
        return (tablet ?? 52).h;
      case ScreenType.desktop:
        return (desktop ?? 56).h;
    }
  }

  // Responsive card height
  static double getCardHeight(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return (mobile ?? 200).h;
      case ScreenType.tablet:
        return (tablet ?? 220).h;
      case ScreenType.desktop:
        return (desktop ?? 240).h;
    }
  }

  // Check if screen is mobile
  static bool isMobile(BuildContext context) {
    return getScreenType(context) == ScreenType.mobile;
  }

  // Check if screen is tablet
  static bool isTablet(BuildContext context) {
    return getScreenType(context) == ScreenType.tablet;
  }

  // Check if screen is desktop
  static bool isDesktop(BuildContext context) {
    return getScreenType(context) == ScreenType.desktop;
  }

  // Get responsive value based on screen type
  static T getResponsiveValue<T>(BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}

enum ScreenType {
  mobile,
  tablet,
  desktop,
}