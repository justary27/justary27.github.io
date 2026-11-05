import 'package:material_ui/material_ui.dart';

abstract final class Motion {
  static const Duration quick = Duration(milliseconds: 150);
  static const Duration swap = Duration(milliseconds: 200);
  static const Duration step = Duration(milliseconds: 300);
  static const Duration tileFlip = Duration(milliseconds: 320);
  static const Duration zoom = Duration(milliseconds: 480);
  static const Duration landing = Duration(milliseconds: 560);
  static const Duration glideWithinYear = Duration(milliseconds: 350);
  static const Duration glideBetweenYears = Duration(milliseconds: 800);
  static const Duration draw = Duration(milliseconds: 900);
  static const Duration slowDraw = Duration(milliseconds: 2200);
  static const Duration cadence = Duration(milliseconds: 3500);
}

abstract final class MotionCurves {
  static const Curve standard = Cubic(.2, .8, .2, 1);
  static const Curve step = Cubic(.65, 0, .35, 1);
  static const Curve bounce = Cubic(.3, 1.35, .5, 1);
  static const Curve draw = Cubic(.4, .1, .2, 1);
}
