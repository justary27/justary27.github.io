import 'package:material_ui/material_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

/// A title held before a promotion at the same company.
class EarlierRole {
  final String role;
  final String duration;

  const EarlierRole({required this.role, required this.duration});
}

/// One role at a company, for entries with a promotion. Newest first; each
/// role keeps its own points and may carry its own headline number.
class RoleChapter {
  final String role;
  // Upper-case tag for the step label, e.g. "SENIOR".
  final String short;
  final String duration;
  final List<ScrollablePoint> points;
  final String? headline;
  final String? headlineCaption;

  const RoleChapter({
    required this.role,
    required this.short,
    required this.duration,
    required this.points,
    this.headline,
    this.headlineCaption,
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

  // An empty diagram marks a text-only point: listed, but with no figure step.
  bool get hasFigure => !(graphic.type == GraphicType.diagram && graphic.path.isEmpty);
}

/// Link for work experience (company website, blog posts, etc.)
class WorkLink {
  final String url;
  final FaIconData icon;
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

  // Promotions: one chapter per role, newest first. Empty for a single role,
  // which then comes from coreInfo and scrollablePoints.
  final List<RoleChapter> chapters;
  // The one number in the summary, with its caption.
  final String? headline;
  final String? headlineCaption;
  // Meta-caps tags, e.g. "GO · SQS · FCM".
  final String? stack;

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
    this.chapters = const [],
    this.headline,
    this.headlineCaption,
    this.stack,
  });
}

extension WorkRoles on WorkExperience {
  List<RoleChapter> get roleChapters => chapters.isNotEmpty
      ? chapters
      : [
          RoleChapter(
            role: coreInfo.role,
            short: "",
            duration: coreInfo.duration,
            points: scrollablePoints,
          ),
        ];
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

  // Oldest first; the ladder ends at coreInfo's role.
  final List<EarlierRole> earlierRoles;
  // A role at this organisation told in Experience, shown as a dashed chip
  // that jumps there instead of repeating it.
  final String? earlierInExperience;
  final String? experienceId;

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
    this.earlierRoles = const [],
    this.earlierInExperience,
    this.experienceId,
  });
}
