import 'package:material_ui/material_ui.dart';

/// A single scrollable sub-step within a Who section.
/// Supports up to 5 photos for the collage.
class WhoSubStep {
  final String text;
  final List<String> photos; // asset paths, max 5

  WhoSubStep({required this.text, this.photos = const []})
    : assert(photos.length <= 5, 'Collage supports a maximum of 5 photos');
}

/// A top-level section on the Who page (Present, Past, Future).
class WhoSection {
  final String label;
  final Color accentShade;
  final List<WhoSubStep> steps;

  const WhoSection({
    required this.label,
    required this.accentShade,
    required this.steps,
  });
}

enum WhoKind { work, code, life, trip, writing }

// A taped photo or a link card beside an entry; up to three per entry.
class WhoMedia {
  final String? caption;
  final String? image;
  final WhoLinkKind? link;
  final String? title;
  final String? url;
  // A YouTube stream that was live.
  final bool live;

  const WhoMedia.photo({this.caption, this.image})
    : link = null,
      title = null,
      url = null,
      live = false;

  const WhoMedia.link(
    WhoLinkKind this.link, {
    required this.title,
    required this.url,
    this.live = false,
  }) : caption = null,
       image = null;

  bool get isPhoto => link == null;
}

enum WhoLinkKind { youtube, x, instagram, medium, github, news }

class WhoEntry {
  // 1–12; places the entry on its year's month ruler.
  final int month;
  final String when;
  final WhoKind kind;
  final String title;
  final String text;
  final String? note;
  final List<WhoMedia> media;
  // Work entries link to their Work page entry.
  final String? workId;

  const WhoEntry({
    required this.month,
    required this.when,
    required this.kind,
    required this.title,
    required this.text,
    this.note,
    this.media = const [],
    this.workId,
  });
}

class WhoYear {
  final String year;
  final List<WhoEntry> entries;

  const WhoYear({required this.year, required this.entries});
}
