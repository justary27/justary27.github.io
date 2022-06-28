import 'dart:ui';

final double pixelRatio = window.devicePixelRatio;

final Size logicalScreenSize = window.physicalSize / pixelRatio;

final double logicalWidth = logicalScreenSize.width;
final double logicalHeight = logicalScreenSize.height;
