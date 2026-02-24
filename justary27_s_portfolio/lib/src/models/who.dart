import 'package:flutter/material.dart';

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
