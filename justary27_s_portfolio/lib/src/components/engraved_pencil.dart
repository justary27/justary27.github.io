import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import '../themes/typography.dart';

class EngravedPencil extends StatelessWidget {
  static const double aspectRatio = 520 / 22;

  final double width;

  const EngravedPencil({super.key, required this.width});

  static const String _svg =
      '''
<svg viewBox="0 0 520 22" xmlns="http://www.w3.org/2000/svg">
  <path d="M4 1H468C486 1 499 7.6 507 8.6V13.4C499 14.4 486 21 468 21H4Q1 21 1 18V4Q1 1 4 1Z" fill="#FAFAFA" stroke="#C9C9C9"/>
  <path d="M4 17H468C478 17 486 18.8 492 19.8C486 20.6 478 21 468 21H4Q1.4 21 1.1 18.4Z" fill="#E9E9E9"/>
  <path d="M6 4.5H462" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round"/>
  <rect x="505" y="8.4" width="13" height="5.2" rx="2.6" fill="#E2E2E2" stroke="#C9C9C9" stroke-width=".8"/>
  <text x="210" y="14.5" font-family="${AppFonts.text}" font-size="10" font-weight="700" letter-spacing="1" fill="#B5B5B5">justary27</text>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _svg,
      width: width,
      height: width / aspectRatio,
      semanticsLabel: "Apple Pencil engraved justary27",
    );
  }
}
