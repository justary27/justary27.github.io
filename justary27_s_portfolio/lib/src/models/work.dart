import 'package:flutter/material.dart';

import '../enums/work.dart';

/// Core information that stays visible (static) in work experience
class CoreInfo {
  final String role;
  final String duration;
  final String overview;

  const CoreInfo({
    required this.role,
    required this.duration,
    required this.overview,
  });
}

/// Graphic asset information
class Graphic {
  final String path;
  final GraphicType type;
  final String? description;

  const Graphic({required this.path, required this.type, this.description});
}

/// Scrollable point with associated graphic
class ScrollablePoint {
  final String text;
  final Graphic graphic;
  final Color? highlightColor;

  const ScrollablePoint({
    required this.text,
    required this.graphic,
    this.highlightColor,
  });
}

/// Link for work experience (company website, blog posts, etc.)
class WorkLink {
  final String url;
  final IconData icon;
  final String label;

  const WorkLink({required this.url, required this.icon, required this.label});
}

/// Work Experience model
class WorkExperience {
  final String id;
  final String company;
  final Graphic coreGraphic;
  final CoreInfo coreInfo;
  final List<ScrollablePoint> scrollablePoints;
  final List<WorkLink> links;
  final Color cardBackgroundColor;
  final Color highlightColor;
  final Color primaryColor;
  final Color secondaryColor;

  /// Path to a local SVG asset used as the logo in the QuickNavBar.
  /// If null, a generic [Icons.business] icon is shown instead.
  final String? logoSvgPath;

  const WorkExperience({
    required this.id,
    required this.company,
    required this.coreGraphic,
    required this.coreInfo,
    required this.scrollablePoints,
    this.links = const [],
    this.cardBackgroundColor = Colors.white,
    required this.highlightColor,
    required this.primaryColor,
    required this.secondaryColor,
    this.logoSvgPath,
  });
}

/// Position of Responsibility model
class Position {
  final String id;
  final String organization;
  final Graphic coreGraphic;
  final CoreInfo coreInfo;
  final List<WorkLink> links;
  final List<String> linkedProjectIds;
  final Color cardBackgroundColor;
  final Color highlightColor;
  final Color primaryColor;
  final Color secondaryColor;

  /// Path to a local SVG asset used as the logo in the QuickNavBar.
  /// If null, a generic [Icons.star_outline] icon is shown instead.
  final String? logoSvgPath;

  const Position({
    required this.id,
    required this.organization,
    required this.coreGraphic,
    required this.coreInfo,
    this.links = const [],
    this.linkedProjectIds = const [],
    this.cardBackgroundColor = Colors.white,
    required this.highlightColor,
    required this.primaryColor,
    required this.secondaryColor,
    this.logoSvgPath,
  });
}
