import '../../../themes/typography.dart';

abstract final class DeskArt {
  static String coffee(int sips) {
    final level = (104 - sips * 20).clamp(0, 104);
    return '''
<svg viewBox="0 0 96 150" xmlns="http://www.w3.org/2000/svg">
  <path d="M14 28 H82 L72 146 H24 Z" fill="#FFFFFF" stroke="#E2E2E2" stroke-width="1.5"/>
  <rect x="8" y="16" width="80" height="14" rx="5" fill="#ECECEC"/>
  <path d="M18 6 H78 L82 16 H14 Z" fill="#E2E2E2"/>
  <rect x="24" y="${144 - level}" width="48" height="$level" fill="#C69C6D" fill-opacity=".22"/>
  <path d="M18 62 H78 L74 104 H22 Z" fill="#C69C6D"/>
  <circle cx="48" cy="83" r="13" fill="#00704A"/>
  <text x="30" y="54" font-family="${AppFonts.hand}" font-size="18" fill="#333333" transform="rotate(-6 48 54)">Aryan</text>
</svg>
''';
  }

  static const String headphones = '''
<svg viewBox="0 0 130 120" xmlns="http://www.w3.org/2000/svg">
  <path d="M18 78 V64 C 18 30, 112 30, 112 64 V78" fill="none" stroke="#0D0D0D" stroke-width="10" stroke-linecap="round"/>
  <rect x="6" y="68" width="30" height="44" rx="12" fill="#9E9E9E"/>
  <rect x="94" y="68" width="30" height="44" rx="12" fill="#9E9E9E"/>
</svg>
''';

  static const String controller = '''
<svg viewBox="0 0 150 110" xmlns="http://www.w3.org/2000/svg">
  <path d="M30 20 H120 C 142 20, 150 50, 146 80 C 143 100, 125 104, 112 88 L100 74 H50 L38 88 C 25 104, 7 100, 4 80 C 0 50, 8 20, 30 20 Z" fill="#0D0D0D"/>
  <rect x="30" y="44" width="26" height="8" rx="2" fill="#82F6B0"/>
  <rect x="39" y="35" width="8" height="26" rx="2" fill="#82F6B0"/>
  <circle cx="104" cy="40" r="6" fill="#B8C6FF"/>
  <circle cx="118" cy="54" r="6" fill="#FFECAA"/>
  <circle cx="90" cy="54" r="6" fill="#A81D13"/>
</svg>
''';

  static const String sketchbook = '''
<svg viewBox="0 0 210 160" xmlns="http://www.w3.org/2000/svg">
  <g fill="#BDBDBD">
    <circle cx="30" cy="7" r="3"/><circle cx="60" cy="7" r="3"/><circle cx="90" cy="7" r="3"/>
    <circle cx="120" cy="7" r="3"/><circle cx="150" cy="7" r="3"/><circle cx="180" cy="7" r="3"/>
  </g>
  <rect x="24" y="36" width="70" height="96" rx="10" fill="none" stroke="#0D0D0D" stroke-width="2"/>
  <rect x="108" y="36" width="78" height="40" rx="8" fill="none" stroke="#0D0D0D" stroke-width="2" stroke-dasharray="5 4"/>
  <path d="M108 100 H186 M108 116 H160" stroke="#0D0D0D" stroke-width="2" stroke-linecap="round"/>
</svg>
''';
}
