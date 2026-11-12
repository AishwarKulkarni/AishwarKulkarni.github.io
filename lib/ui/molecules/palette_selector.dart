import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/crew_palette.dart';

/// Palette color selector molecule for customizing crewmate avatar color.
class PaletteSelector extends StatelessWidget {
  const PaletteSelector({
    super.key,
    required this.palettes,
    required this.selectedIndex,
    required this.onColorSelected,
  });

  final List<CrewPalette> palettes;
  final int selectedIndex;
  final ValueChanged<int> onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < palettes.length; i++)
            GestureDetector(
              onTap: () => onColorSelected(i),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: selectedIndex == i ? 18 : 12,
                  height: selectedIndex == i ? 18 : 12,
                  decoration: BoxDecoration(
                    color: palettes[i].primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedIndex == i ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: selectedIndex == i
                        ? [
                            BoxShadow(
                              color: palettes[i].primary.withValues(alpha: 0.5),
                              blurRadius: 8,
                            ),
                          ]
                        : const [],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
