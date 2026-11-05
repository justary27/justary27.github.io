import 'package:material_ui/material_ui.dart';

import 'route_ink.dart';
import 'typography.dart';

abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    fontFamily: AppFonts.text,
    extensions: const [RouteInk.home],
  );
}
