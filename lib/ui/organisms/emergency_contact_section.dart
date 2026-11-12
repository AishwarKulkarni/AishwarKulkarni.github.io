import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../atoms/glass_panel.dart';
import '../atoms/primary_button.dart';

/// Contact section organism with an animated pulsing emergency reactor button.
class EmergencyContactSection extends StatelessWidget {
  const EmergencyContactSection({
    super.key,
    required this.sectionKey,
    required this.spaceAnimation,
    required this.onTriggerEmergencyMeeting,
  });

  final GlobalKey sectionKey;
  final Animation<double> spaceAnimation;
  final VoidCallback onTriggerEmergencyMeeting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: GlassPanel(
            accentColor: AppColors.red,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
            child: Column(
              children: [
                // Big Red Button with Pulses
                SizedBox(
                  width: 220,
                  height: 220,
                  child: AnimatedBuilder(
                    animation: spaceAnimation,
                    builder: (_, _) {
                      final time = spaceAnimation.value * 120;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          for (var k = 0; k < 3; k++)
                            Transform.scale(
                              scale: 1.0 + ((time * 0.4 + k * 0.33) % 1.0) * 1.3,
                              child: Opacity(
                                opacity: (1.0 - ((time * 0.4 + k * 0.33) % 1.0)) * 0.45,
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.red, width: 2),
                                  ),
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: onTriggerEmergencyMeeting,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const RadialGradient(
                                    colors: [Color(0xFFFF5252), AppColors.red, Color(0xFF991B1B)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.red.withValues(alpha: 0.55),
                                      blurRadius: 40,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/sabotage/reactor.svg',
                                    width: 66,
                                    height: 66,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Need an Experienced Flutter Engineer?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Text(
                    'Call an Emergency Meeting to discuss architecture, freelance projects, or full-time opportunities.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      color: AppColors.dim,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Call Emergency Meeting',
                  icon: Icons.campaign_rounded,
                  color: AppColors.red,
                  onTap: onTriggerEmergencyMeeting,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
