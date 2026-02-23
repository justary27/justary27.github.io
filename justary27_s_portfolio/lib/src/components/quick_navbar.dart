import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickNavBar extends StatefulWidget {
  final List<QuickNavItem> items;
  final Function(int) onItemTap;
  final int currentIndex;

  const QuickNavBar({
    super.key,
    required this.items,
    required this.onItemTap,
    this.currentIndex = 0,
  });

  @override
  State<QuickNavBar> createState() => _QuickNavBarState();
}

class _QuickNavBarState extends State<QuickNavBar>
    with SingleTickerProviderStateMixin {
  int? _hoveredIndex;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF389583).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.items.length, (index) {
              if (index > 0) {
                return Column(
                  children: [const SizedBox(height: 4), _buildNavItem(index)],
                );
              }
              return _buildNavItem(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = widget.items[index];
    final isHovered = _hoveredIndex == index;
    final isActive = widget.currentIndex == index;

    // Resolve icon color for the current state
    final iconColor =
        isActive
            ? Colors.white
            : isHovered
            ? const Color(0xFF389583)
            : Colors.grey.shade600;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onItemTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow ring for active state
              if (isActive)
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(
                              0xFF389583,
                            ).withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),

              // Main dot container
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                width: isActive ? 44 : (isHovered ? 40 : 36),
                height: isActive ? 44 : (isHovered ? 40 : 36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isActive
                          ? const Color(0xFF389583)
                          : isHovered
                          ? const Color(0xFF389583).withValues(alpha: 0.15)
                          : Colors.grey.withValues(alpha: 0.1),
                  boxShadow:
                      isActive
                          ? [
                            BoxShadow(
                              color: const Color(
                                0xFF389583,
                              ).withValues(alpha: 0.4),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ]
                          : null,
                ),
                // Render SVG logo if path provided, otherwise fall back to IconData
                child:
                    item.svgPath != null
                        ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            item.svgPath!,
                            colorFilter: ColorFilter.mode(
                              iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                        : Icon(
                          item.icon ?? Icons.circle_outlined,
                          size: isActive ? 22 : (isHovered ? 20 : 18),
                          color: iconColor,
                        ),
              ),

              // Tooltip label on hover (left side)
              if (isHovered && !isActive)
                Positioned(
                  right: 60,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: "ABeeZee",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Active label (always shown for active item)
              if (isActive)
                Positioned(
                  right: 60,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF389583),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF389583).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      item.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "ABeeZee",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickNavItem {
  final String label;

  /// Fallback icon shown when [svgPath] is null.
  final IconData? icon;

  /// Path to a local SVG asset. When set, this takes priority over [icon].
  final String? svgPath;

  const QuickNavItem({required this.label, this.icon, this.svgPath})
    : assert(
        icon != null || svgPath != null,
        'QuickNavItem requires either an icon or an svgPath',
      );
}
