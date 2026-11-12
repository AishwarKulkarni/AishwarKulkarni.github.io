import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../models/skill_category.dart';
import '../atoms/glass_panel.dart';

/// Interactive skill category card displaying icon, title, task SVG, and skill chips.
class SkillCategoryCard extends StatefulWidget {
  const SkillCategoryCard({super.key, required this.category});

  final SkillCategory category;

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GlassPanel(
        isHovered: _hover,
        accentColor: widget.category.color,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.category.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: widget.category.color.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Icon(widget.category.icon, size: 20, color: widget.category.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  widget.category.title.startsWith('Core')
                      ? 'assets/tasks/wires.svg'
                      : widget.category.title.startsWith('Mobile')
                          ? 'assets/tasks/swipe_card.svg'
                          : 'assets/tasks/download.svg',
                  width: 30,
                  height: 30,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final skill in widget.category.skills)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: widget.category.color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: widget.category.color.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      skill,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
