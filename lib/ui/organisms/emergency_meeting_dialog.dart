import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../data/portfolio_data.dart';
import '../atoms/glass_panel.dart';
import '../molecules/emergency_tile.dart';

/// Fullscreen animated emergency meeting dialogue organism with direct comms dispatch.
class EmergencyMeetingDialog extends StatefulWidget {
  const EmergencyMeetingDialog({super.key});

  @override
  State<EmergencyMeetingDialog> createState() => _EmergencyMeetingDialogState();
}

class _EmergencyMeetingDialogState extends State<EmergencyMeetingDialog> {
  bool _showPanel = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (mounted) setState(() => _showPanel = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 320),
        child: _showPanel ? _buildDialogPanel() : _buildSlamScreen(),
      ),
    );
  }

  Widget _buildSlamScreen() {
    return SizedBox.expand(
      key: const ValueKey('slam'),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              AppColors.red.withValues(alpha: 0.95),
              const Color(0xFF7F1D1D),
              Colors.black,
            ],
            radius: 1.2,
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 2.2, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            builder: (_, s, child) => Transform.scale(scale: s, child: child),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.campaign_rounded, size: 84, color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  'EMERGENCY\nMEETING',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'DISPATCHING CREW TO COMMS...',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogPanel() {
    final socialLinks = PortfolioData.socialLinks;
    final palettes = PortfolioData.palettes;

    return Center(
      key: const ValueKey('panel'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: GlassPanel(
            accentColor: AppColors.red,
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.red, Color(0xFF991B1B)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.campaign_rounded, color: Colors.white, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Direct Comms Dispatch',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Select a crew link below to copy directly to clipboard.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.dim,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),

                // Channel link tiles
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var i = 0; i < socialLinks.length; i++)
                      EmergencyTile(
                        color: palettes[i % palettes.length].primary,
                        name: socialLinks[i].name,
                        handle: socialLinks[i].handle,
                        url: socialLinks[i].url,
                        icon: socialLinks[i].icon,
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                // Close / Skip Button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Return to Ship (Close) →',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.dim,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
