import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../models/crew_palette.dart';
import '../../models/social_link.dart';
import '../atoms/primary_button.dart';
import '../atoms/secondary_button.dart';
import '../molecules/hero_mascot.dart';
import '../molecules/social_pill.dart';

/// Hero presentation section organism introducing the engineer and featuring the interactive mascot.
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.screenSize,
    required this.isMobile,
    required this.isTablet,
    required this.activeColor,
    required this.palettes,
    required this.selectedColorIndex,
    required this.transmissionMessage,
    required this.transmissionIndex,
    required this.socialLinks,
    required this.onExploreProjects,
    required this.onViewResume,
    required this.onCycleColor,
    required this.onSelectColor,
  });

  final GlobalKey sectionKey;
  final Size screenSize;
  final bool isMobile;
  final bool isTablet;
  final Color activeColor;
  final List<CrewPalette> palettes;
  final int selectedColorIndex;
  final String transmissionMessage;
  final int transmissionIndex;
  final List<SocialLink> socialLinks;
  final VoidCallback onExploreProjects;
  final VoidCallback onViewResume;
  final VoidCallback onCycleColor;
  final ValueChanged<int> onSelectColor;

  @override
  Widget build(BuildContext context) {
    final heroText = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Availability Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.green.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.green.withValues(alpha: 0.4), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Open to Flutter developer roles & projects',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  color: AppColors.green,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Main Title
        Text(
          'Hi, I\'m Aishwar Kulkarni',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? 38 : 64,
            fontWeight: FontWeight.w900,
            color: AppColors.text,
            letterSpacing: -1.2,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),

        // Gradient Role Subtitle
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [activeColor, AppColors.cyan],
          ).createShader(bounds),
          child: Text(
            'Flutter Developer · Mobile & Full Stack',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 20 : 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.4,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Value Proposition
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            'I build thoughtful Android and iOS apps with Flutter and Dart, and connect them to reliable APIs and backend services. I enjoy turning product ideas into useful, polished experiences.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              color: AppColors.dim,
              height: 1.65,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // CTAs
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PrimaryButton(
              label: 'Explore Projects',
              icon: Icons.rocket_launch_rounded,
              color: activeColor,
              onTap: onExploreProjects,
            ),
            SecondaryButton(
              label: 'Crew Manifest (Resume)',
              icon: Icons.description_outlined,
              onTap: onViewResume,
            ),
          ],
        ),
        const SizedBox(height: 36),

        // Social Chips
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            for (final s in socialLinks) SocialPill.fromModel(s),
          ],
        ),
      ],
    );

    final mascotColumn = HeroMascot(
      isMobile: isMobile,
      activeColor: activeColor,
      transmissionMessage: transmissionMessage,
      transmissionIndex: transmissionIndex,
      palettes: palettes,
      selectedColorIndex: selectedColorIndex,
      onCycleColor: onCycleColor,
      onSelectColor: onSelectColor,
    );

    return ConstrainedBox(
      key: sectionKey,
      constraints: BoxConstraints(minHeight: screenSize.height * 0.95),
      child: Padding(
        padding: EdgeInsets.fromLTRB(28, isMobile ? 100 : 130, 28, 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: isMobile
                ? Column(
                    children: [
                      mascotColumn,
                      const SizedBox(height: 40),
                      heroText,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: heroText),
                      const SizedBox(width: 48),
                      mascotColumn,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
