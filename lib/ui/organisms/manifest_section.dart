import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../data/portfolio_data.dart';
import '../atoms/glass_panel.dart';
import '../atoms/metric_card.dart';
import '../molecules/manifest_id_card.dart';
import '../molecules/resume_entry_card.dart';
import '../molecules/section_header.dart';

/// Manifest & credentials section organism detailing work history and education.
class ManifestSection extends StatelessWidget {
  const ManifestSection({
    super.key,
    required this.sectionKey,
    required this.isMobile,
  });

  final GlobalKey sectionKey;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    const idCard = ManifestIdCard();

    final detailsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final r in PortfolioData.manifestRoles)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(r.icon, size: 18, color: AppColors.cyan.withValues(alpha: 0.8)),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: Text(
                    r.label,
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.dim,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    r.value,
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.text,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 24),
        const Divider(color: AppColors.borderSubtle, height: 1),
        const SizedBox(height: 24),

        // Quick Highlights Row
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            MetricCard(value: '2 YEARS', label: 'Experience', color: AppColors.blue),
            MetricCard(value: '2', label: 'Workplaces', color: AppColors.green),
            MetricCard(value: 'B.E.', label: 'Computer Science', color: AppColors.purple),
            MetricCard(value: 'FLUTTER', label: 'Primary stack', color: AppColors.red),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'EXPERIENCE',
          style: GoogleFonts.jetBrainsMono(
            color: AppColors.cyan,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        const ResumeEntryCard(
          asset: 'assets/crewmates/crew_cyan.svg',
          title: 'Flutter Developer · PropTechBuzz',
          detail: 'Remote · United States · 2025–Present · 3 live apps',
          color: AppColors.cyan,
          description:
              'Build and maintain PropTechBuzz, WildlifeBuzz, and Gomigro for the App Store and Google Play. Ship features across release cycles with Riverpod, REST APIs, Firebase, and push notifications.',
        ),
        const SizedBox(height: 12),
        const ResumeEntryCard(
          asset: 'assets/crewmates/crew_purple.svg',
          title: 'Flutter Developer · Qurinom Solutions',
          detail: 'Remote · Hyderabad · 2024–2025 · HR management app',
          color: AppColors.purple,
          description:
              'Turned Figma designs into production ready Flutter screens, established reusable BLoC based architecture, and set UI patterns adopted across the project.',
        ),
        const SizedBox(height: 28),
        Text(
          'EDUCATION',
          style: GoogleFonts.jetBrainsMono(
            color: AppColors.amber,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        const ResumeEntryCard(
          asset: 'assets/crewmates/crew_yellow.svg',
          title: 'B.E. · Computer Science & Engineering',
          detail: 'Parul University, Gujarat',
          color: AppColors.amber,
        ),
        const SizedBox(height: 12),
        const ResumeEntryCard(
          asset: 'assets/crewmates/crew_green.svg',
          title: 'Diploma · Computer Science & Engineering',
          detail: 'Dhanvantri College of Science and Technology · Kim, Gujarat',
          color: AppColors.green,
        ),
      ],
    );

    return Padding(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                tag: 'Dossier // 01',
                title: 'Crew Manifest & Credentials',
                subtitle:
                    'Ship records, professional history, and production capabilities in Flutter engineering.',
              ),
              const SizedBox(height: 40),
              GlassPanel(
                padding: const EdgeInsets.all(28),
                child: isMobile
                    ? Column(
                        children: [
                          idCard,
                          const SizedBox(height: 32),
                          detailsColumn,
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          idCard,
                          const SizedBox(width: 44),
                          Expanded(child: detailsColumn),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
