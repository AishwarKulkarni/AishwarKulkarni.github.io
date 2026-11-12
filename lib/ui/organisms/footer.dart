import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../atoms/crew.dart';

/// Page footer organism with mascot badge and copyright info.
class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key, required this.activeColor});

  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Row(
            children: [
              Crew(color: activeColor, height: 28),
              const SizedBox(width: 10),
              Text(
                'Aishwar Kulkarni',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                'Built with Flutter 3 · Designed for Production',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: AppColors.dimmer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

