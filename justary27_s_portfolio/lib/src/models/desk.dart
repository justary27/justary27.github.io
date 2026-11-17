import 'dart:ui';

class DeskPeek {
  final String eyebrow;
  final String title;
  final String body;
  final String? linkLabel;
  final String? linkUrl;
  // Where the dashed line leaves the object, in desk coordinates.
  final double fromX;
  final double fromY;
  final double cardX;
  // The same on the tablet desk, where the card also moves down the stage.
  final Offset tabletFrom;
  final Offset tabletCard;

  const DeskPeek({
    required this.eyebrow,
    required this.title,
    required this.body,
    this.linkLabel,
    this.linkUrl,
    required this.fromX,
    required this.fromY,
    required this.cardX,
    required this.tabletFrom,
    required this.tabletCard,
  });
}
