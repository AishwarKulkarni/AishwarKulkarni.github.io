import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../atoms/primary_button.dart';
import '../molecules/brand_logo.dart';
import '../molecules/nav_link_item.dart';

/// Top sticky navigation bar organism featuring logo, page anchors, emergency trigger, and scroll progress.
class PortfolioNavigationBar extends StatelessWidget {
  const PortfolioNavigationBar({
    super.key,
    required this.isMobile,
    required this.isScrolled,
    required this.activeColor,
    required this.navLabels,
    required this.activeSection,
    required this.scrollProgress,
    required this.onNavigate,
    required this.onEmergencyMeeting,
  });

  final bool isMobile;
  final bool isScrolled;
  final Color activeColor;
  final List<String> navLabels;
  final ValueNotifier<int> activeSection;
  final ValueNotifier<double> scrollProgress;
  final ValueChanged<int> onNavigate;
  final VoidCallback onEmergencyMeeting;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.bg.withValues(alpha: 0.85) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.borderSubtle : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: isScrolled ? 18 : 0,
            sigmaY: isScrolled ? 18 : 0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    BrandLogo(
                      activeColor: activeColor,
                      onTap: () => onNavigate(0),
                    ),
                    const Spacer(),

                    // Nav links
                    if (isMobile)
                      PopupMenuButton<int>(
                        icon: const Icon(Icons.menu_rounded, color: AppColors.textSecondary),
                        color: AppColors.panelElevated,
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(color: AppColors.border),
                        ),
                        onSelected: onNavigate,
                        itemBuilder: (_) => [
                          for (var i = 0; i < navLabels.length; i++)
                            PopupMenuItem(
                              value: i,
                              child: Text(
                                navLabels[i],
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      )
                    else
                      ValueListenableBuilder<int>(
                        valueListenable: activeSection,
                        builder: (_, activeIdx, _) => Row(
                          children: [
                            for (var i = 0; i < navLabels.length; i++)
                              NavLinkItem(
                                label: navLabels[i],
                                isActive: activeIdx == i,
                                onTap: () => onNavigate(i),
                              ),
                            const SizedBox(width: 16),
                            PrimaryButton(
                              label: 'Emergency Meeting',
                              icon: Icons.campaign_rounded,
                              color: AppColors.red,
                              onTap: onEmergencyMeeting,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Scroll Progress Bar
              ValueListenableBuilder<double>(
                valueListenable: scrollProgress,
                builder: (_, progress, _) => SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(activeColor),
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
