import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Glassmorphism container atom with blur backdrop, rounded corners, and hover glow.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 20.0,
    this.accentColor,
    this.isHovered = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? accentColor;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: padding,
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.panelElevated.withValues(alpha: 0.85)
                : AppColors.panel.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: accentColor != null
                  ? accentColor!.withValues(alpha: isHovered ? 0.6 : 0.3)
                  : (isHovered ? AppColors.borderBright : AppColors.borderSubtle),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
              if (accentColor != null && isHovered)
                BoxShadow(
                  color: accentColor!.withValues(alpha: 0.18),
                  blurRadius: 36,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
