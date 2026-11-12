import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../atoms/section_tag_chip.dart';

/// Section header molecule featuring a category tag chip, main title, and explanatory subtitle.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    this.tagColor = AppColors.blue,
  });

  final String tag;
  final String title;
  final String subtitle;
  final Color tagColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTagChip(tag: tag, color: tagColor),
        const SizedBox(height: 14),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              color: AppColors.dim,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

