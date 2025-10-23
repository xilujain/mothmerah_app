import 'package:flutter/material.dart';

class ScrollableWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool enableBouncing;
  final ScrollPhysics? physics;
  final bool enableKeyboardDismiss;

  const ScrollableWrapper({
    super.key,
    required this.child,
    this.padding,
    this.enableBouncing = true,
    this.physics,
    this.enableKeyboardDismiss = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enableKeyboardDismiss
          ? () => FocusScope.of(context).unfocus()
          : null,
      child: SingleChildScrollView(
        physics:
            physics ??
            (enableBouncing
                ? const BouncingScrollPhysics()
                : const ClampingScrollPhysics()),
        padding: padding,
        child: child,
      ),
    );
  }
}
