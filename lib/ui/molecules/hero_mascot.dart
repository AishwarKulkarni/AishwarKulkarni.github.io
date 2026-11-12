import 'package:flutter/material.dart';

import '../../models/crew_palette.dart';
import '../atoms/crew.dart';
import 'comms_bubble.dart';
import 'palette_selector.dart';

/// Interactive mascot composite molecule for the hero section.
class HeroMascot extends StatelessWidget {
  const HeroMascot({
    super.key,
    required this.isMobile,
    required this.activeColor,
    required this.transmissionMessage,
    required this.transmissionIndex,
    required this.palettes,
    required this.selectedColorIndex,
    required this.onCycleColor,
    required this.onSelectColor,
  });

  final bool isMobile;
  final Color activeColor;
  final String transmissionMessage;
  final int transmissionIndex;
  final List<CrewPalette> palettes;
  final int selectedColorIndex;
  final VoidCallback onCycleColor;
  final ValueChanged<int> onSelectColor;

  @override
  Widget build(BuildContext context) {
    final mascotHeight = isMobile ? 220.0 : 340.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Comms Bubble
        CommsBubble(
          message: transmissionMessage,
          index: transmissionIndex,
          activeColor: activeColor,
        ),
        const SizedBox(height: 24),

        // Glowing Mascot
        GestureDetector(
          onTap: onCycleColor,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow Halo
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  width: mascotHeight * 1.3,
                  height: mascotHeight * 1.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        activeColor.withValues(alpha: 0.28),
                        activeColor.withValues(alpha: 0.04),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
                Crew(color: activeColor, height: mascotHeight, bob: true),
              ],
            ),
          ),
        ),

        // Ground shadow
        Container(
          width: isMobile ? 120 : 180,
          height: 12,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.black.withValues(alpha: 0.6),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(height: 16),

        // Color Swatch Selector
        PaletteSelector(
          palettes: palettes,
          selectedIndex: selectedColorIndex,
          onColorSelected: onSelectColor,
        ),
      ],
    );
  }
}
