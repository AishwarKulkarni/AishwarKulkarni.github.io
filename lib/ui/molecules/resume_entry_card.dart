import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// Resume timeline entry molecule with crew SVG avatar, titles, and project notes.
class ResumeEntryCard extends StatelessWidget {
  const ResumeEntryCard({
    super.key,
    required this.asset,
    required this.title,
    required this.detail,
    required this.color,
    this.description,
  });

  final String asset;
  final String title;
  final String detail;
  final Color color;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          SvgPicture.asset(asset, width: 30, height: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.text,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: GoogleFonts.plusJakartaSans(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 7),
                  Text(
                    description!,
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.dim,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

