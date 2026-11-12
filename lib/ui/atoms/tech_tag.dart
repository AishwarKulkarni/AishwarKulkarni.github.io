import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// Tag / Badge atom for technology names.
class TechTag extends StatefulWidget {
  const TechTag(this.label, {super.key});

  final String label;

  @override
  State<TechTag> createState() => _TechTagState();
}

class _TechTagState extends State<TechTag> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: _hover ? AppColors.blue.withValues(alpha: 0.18) : AppColors.surface.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hover ? AppColors.blue.withValues(alpha: 0.55) : AppColors.borderSubtle,
            width: 1.0,
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _hover ? AppColors.text : AppColors.dim,
          ),
        ),
      ),
    );
  }
}
