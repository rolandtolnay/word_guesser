import 'package:flutter/material.dart';

class MaxWidthContainer extends StatelessWidget {
  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = kTabletWidth,
    this.maxHeight = double.infinity,
  });

  final Widget child;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
        child: child,
      ),
    );
  }
}

const kPhoneHeightSmall = 736.0;
const kPhoneHeightSmallest = 568.0;

const kPhoneWidth = 428.0;
const kTabletWidth = 768.0;
const kDesktopWidth = 1180.0;

extension BuildContextExtScreenSize on BuildContext {
  bool get isSmallScreen =>
      MediaQuery.of(this).size.height <= kPhoneHeightSmall;

  bool get isSmallestScreen =>
      MediaQuery.of(this).size.height <= kPhoneHeightSmallest;

  bool get isDesktopScreen => MediaQuery.of(this).size.width >= kDesktopWidth;

  bool get isTabletScreen => MediaQuery.of(this).size.width >= kTabletWidth;

  ScreenSize get screenSize {
    if (isSmallestScreen) return ScreenSize.smallestPhone;
    if (isSmallScreen) return ScreenSize.smallPhone;
    if (isDesktopScreen) return ScreenSize.desktop;
    if (isTabletScreen) return ScreenSize.tablet;
    return ScreenSize.phone;
  }
}

enum ScreenSize { smallestPhone, smallPhone, phone, tablet, desktop }
