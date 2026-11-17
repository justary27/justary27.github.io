import 'dart:ui';

// Which reflow of the pages a window gets. Every window gets the same page
// tree; tablet (iPads in portrait, 744–1024) and phone reflow it.
enum Layout {
  phone,
  tablet,
  large;

  static const double tabletMin = 744;
  static const double tabletMax = 1024;
  // Landscape phones are phones: judged by their shortest side.
  static const double phoneShortestSide = 500;

  static Layout of(Size size) {
    if (size.width < tabletMin || size.shortestSide < phoneShortestSide) {
      return phone;
    }
    // A 1024-wide landscape window is a laptop or a landscape iPad.
    if (size.width < tabletMax ||
        (size.width <= tabletMax && size.height > size.width)) {
      return tablet;
    }
    return large;
  }

  bool get isPhone => this == phone;
  bool get isTablet => this == tablet;
  // Tablet and phone share the stacked reflows; phone tightens some further.
  bool get isCompact => this != large;
}
