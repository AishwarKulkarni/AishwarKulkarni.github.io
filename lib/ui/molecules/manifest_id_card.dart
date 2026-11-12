import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../data/portfolio_data.dart';
import '../atoms/barcode.dart';
import '../atoms/crew.dart';

/// Manifest ID badge molecule showing character photo, clearance status, and barcode.
class ManifestIdCard extends StatelessWidget {
  const ManifestIdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: AppColors.panelElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderBright, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withValues(alpha: 0.12),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Top accent strip
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.blue, AppColors.cyan]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                // Mascot Photo Holder
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Crew(
                        color: PortfolioData.palettes[3].primary,
                        height: 130,
                        bob: true,
                      ),
                      Positioned(
                        top: 16,
                        right: 34,
                        child: SvgPicture.asset(
                          'assets/hats/sprout.svg',
                          width: 34,
                          height: 34,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'AISHWAR',
                  style: GoogleFonts.jetBrainsMono(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    letterSpacing: 1.5,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: FLUTTER-SPEC-01',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: AppColors.dim,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.green.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 12, color: AppColors.green),
                      const SizedBox(width: 6),
                      Text(
                        'NOT IMPOSTOR',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const BarcodeWidget(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
