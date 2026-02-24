import 'package:flutter_riverpod/flutter_riverpod.dart';

/// true  = visible (default)
/// false = hidden (slid off screen)
final navbarVisibleProvider = StateProvider<bool>((ref) => true);
