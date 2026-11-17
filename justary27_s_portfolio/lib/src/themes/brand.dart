import 'package:material_ui/material_ui.dart';

// Route Ink "Brand scope": per-entry colours taken from the logo files.
// A brand paints only inside its own entry: panel tint, figure ink, headline
// number, stack tags, name underline, rail ring, link pills and the 3D coin.
// Text on a brand surface uses its dark, never black or grey.
class BrandInk {
  final Color brand;
  final Color dark;
  final Color soft;
  final Color tint;
  // For a logo file drawn in one flat colour that vanishes on the page.
  final Color? logoTint;
  // The logo file is a full-bleed square icon, so it's cut to a circle.
  final bool logoIsTile;

  const BrandInk({
    required this.brand,
    required this.dark,
    required this.soft,
    required this.tint,
    this.logoTint,
    this.logoIsTile = false,
  });
}

abstract final class Brands {
  // Keyed by the entry ids in pages/work/data.dart.
  static const Map<String, BrandInk> experience = {
    '8club': BrandInk(
      brand: Color(0xFF9D91F7),
      dark: Color(0xFF331D65),
      soft: Color(0xFFD8D3FC),
      tint: Color(0xFFF0EEFE),
      logoIsTile: true,
    ),
    'repello': BrandInk(
      brand: Color(0xFF556CFF),
      dark: Color(0xFF27358B),
      soft: Color(0xFFC9D1FF),
      tint: Color(0xFFE6E9FF),
    ),
    'clouddefense': BrandInk(
      brand: Color(0xFF00C37D),
      dark: Color(0xFF00704F),
      soft: Color(0xFFB8EFD6),
      tint: Color(0xFFD9F6EC),
    ),
    // Prime Video team: the slate the amazon.gltf renders in (its material
    // is #182236, read as linear), not Amazon orange. Soft is the brand 25%
    // over white; tint is 15%, the panel rule in Foundations.
    'amazon': BrandInk(
      brand: Color(0xFF56667F),
      dark: Color(0xFF182236),
      soft: Color(0xFFD5D9DF),
      tint: Color(0xFFE6E8EC),
      logoTint: Color(0xFF56667F),
    ),
    'gsoc22': BrandInk(
      brand: Color(0xFFFBBC05),
      dark: Color(0xFF7A5A00),
      soft: Color(0xFFFDE49A),
      tint: Color(0xFFFEF5DA),
    ),
  };

  // The table gives projects no soft tone, so soft repeats the tint.
  // White logo files take their 3D model's colour (the brand) as a tint.
  static const Map<String, BrandInk> projects = {
    'noticeboard': BrandInk(
      brand: Color(0xFF00AADB),
      dark: Color(0xFF005F7A),
      soft: Color(0xFFEAF7FC),
      tint: Color(0xFFEAF7FC),
      logoTint: Color(0xFF00AADB),
    ),
    'placement_online': BrandInk(
      brand: Color(0xFF009BFF),
      dark: Color(0xFF00578F),
      soft: Color(0xFFE6F4FF),
      tint: Color(0xFFE6F4FF),
      logoTint: Color(0xFF009BFF),
    ),
    'covbot': BrandInk(
      brand: Color(0xFF16856F),
      dark: Color(0xFF0E5A4B),
      soft: Color(0xFFE8F3F0),
      tint: Color(0xFFE8F3F0),
    ),
    'bugheist_ui': BrandInk(
      brand: Color(0xFFDC4654),
      dark: Color(0xFF8E2330),
      soft: Color(0xFFFBEBED),
      tint: Color(0xFFFBEBED),
    ),
    'lyf': BrandInk(
      brand: Color(0xFF00A293),
      dark: Color(0xFF00635A),
      soft: Color(0xFFE5F5F3),
      tint: Color(0xFFE5F5F3),
      logoTint: Color(0xFF00A293),
    ),
    'jane': BrandInk(
      brand: Color(0xFFFF4500),
      dark: Color(0xFF9A2A00),
      soft: Color(0xFFFFEDE5),
      tint: Color(0xFFFFEDE5),
    ),
  };

  // Positions sit on white cards; the table gives no tint, so tint is white.
  // Keys are organisations; GDSC, NSS and the Student Mentorship Program
  // have no entries in data.dart yet.
  static const Map<String, BrandInk> positions = {
    'img_chief': BrandInk(
      brand: Color(0xFF0E2B85),
      dark: Color(0xFF0E2B85),
      soft: Color(0xFFE7ECFA),
      tint: Colors.white,
    ),
    'gsoc23_mentor': BrandInk(
      brand: Color(0xFFDC4654),
      dark: Color(0xFF8E2330),
      soft: Color(0xFFFBE9EB),
      tint: Colors.white,
    ),
    'gdsc': BrandInk(
      brand: Color(0xFF4285F4),
      dark: Color(0xFF1A4FA8),
      soft: Color(0xFFE8F0FE),
      tint: Colors.white,
    ),
    'nss': BrandInk(
      brand: Color(0xFFC0392B),
      dark: Color(0xFF7A1F17),
      soft: Color(0xFFFBEAE8),
      tint: Colors.white,
    ),
    'smp': BrandInk(
      brand: Color(0xFFC98A00),
      dark: Color(0xFF6B4A00),
      soft: Color(0xFFFBF1D9),
      tint: Colors.white,
    ),
  };
}
