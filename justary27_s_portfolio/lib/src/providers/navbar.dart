import 'package:flutter_riverpod/flutter_riverpod.dart';

/// true  = visible (default)
/// false = hidden (slid off screen)
class NavbarVisibleNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void show() => state = true;
  void hide() => state = false;
}

final navbarVisibleProvider = NotifierProvider<NavbarVisibleNotifier, bool>(
  NavbarVisibleNotifier.new,
);
