import 'package:material_ui/material_ui.dart';

import 'colors.dart';

abstract final class AppFonts {
  static const String signature = 'Allison';
  static const String hand = 'CoveredByYourGrace';
  static const String text = 'RedHatDisplay';
}

abstract final class AppText {
  // Hero titles are sized by the page, clamped to these bounds.
  static const double routeMinSize = 150;
  static const double routeMaxSize = 280;
  static const TextStyle route = TextStyle(
    fontFamily: AppFonts.hand,
    height: 1,
  );

  static const TextStyle signatureHero = TextStyle(
    fontFamily: AppFonts.signature,
    fontSize: 104,
    height: 1,
  );
  static const TextStyle signatureFooter = TextStyle(
    fontFamily: AppFonts.signature,
    fontSize: 64,
    height: 1,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: AppColors.ink900,
  );
  static const TextStyle title = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -0.32,
    color: AppColors.ink900,
  );
  static const TextStyle stat = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 40,
    fontWeight: FontWeight.w900,
    height: 1,
    color: AppColors.ink900,
  );
  static const TextStyle statCard = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    height: 1,
    color: AppColors.ink900,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.ink900,
  );
  static const TextStyle bodyL = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.ink900,
  );
  static const TextStyle body = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.ink700,
  );
  static const TextStyle label = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.ink900,
  );
  // Callers upper-case the string; TextStyle has no text-transform.
  static const TextStyle meta = TextStyle(
    fontFamily: AppFonts.text,
    fontSize: 12,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.68,
    color: AppColors.ink500,
  );

  static const TextStyle handSmall = TextStyle(
    fontFamily: AppFonts.hand,
    fontSize: 20,
  );
  static const TextStyle handMedium = TextStyle(
    fontFamily: AppFonts.hand,
    fontSize: 26,
  );
  static const TextStyle handLarge = TextStyle(
    fontFamily: AppFonts.hand,
    fontSize: 40,
  );

  static const TextStyle code = TextStyle(
    fontFamily: 'monospace',
    fontSize: 14,
    color: AppColors.ink900,
  );
}
