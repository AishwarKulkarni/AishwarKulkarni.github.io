import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../models/project_model.dart';
import '../atoms/glass_panel.dart';
import '../atoms/tech_tag.dart';

/// Detailed project showcase card organism displaying architecture, metrics, and technology tags.
class ProjectShowcaseCard extends StatefulWidget {
  const ProjectShowcaseCard({
    super.key,
    required this.project,
    required this.index,
    required this.isMobile,
    this.onTap,
  });

  final ProjectModel project;
  final int index;
  final bool isMobile;
  final VoidCallback? onTap;

  @override
  State<ProjectShowcaseCard> createState() => _ProjectShowcaseCardState();
}

class _ProjectShowcaseCardState extends State<ProjectShowcaseCard> {
  bool _hover = false;

  bool get _hasLink =>
      widget.onTap != null || widget.project.hasLink;

  Future<void> _handleTap() async {
    if (widget.onTap != null) {
      widget.onTap!();
      return;
    }

    final link = widget.project.linkUrl;
    if (link == null || link.trim().isEmpty) return;

    var formatted = link.trim();
    if (!formatted.startsWith('http://') && !formatted.startsWith('https://')) {
      formatted = 'https://$formatted';
    }

    final uri = Uri.tryParse(formatted);
    if (uri != null) {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint('Could not launch project url: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _hasLink ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _hasLink ? _handleTap : null,
        child: GlassPanel(
          isHovered: _hover,
          accentColor: widget.project.accent,
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.project.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.project.accent.withValues(alpha: 0.4),
                      ),
                    ),
                    child: SvgPicture.asset(
                      widget.index == 1
                          ? 'assets/tasks/swipe_card.svg'
                          : widget.index == 2
                              ? 'assets/tasks/fuel.svg'
                              : 'assets/tasks/download.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.project.title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: _hover && _hasLink
                                      ? widget.project.accent
                                      : AppColors.text,
                                ),
                              ),
                            ),
                            if (_hasLink) ...[
                              const SizedBox(width: 8),
                              Tooltip(
                                message: 'Open project link',
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 160),
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: widget.project.accent.withValues(
                                      alpha: _hover ? 0.22 : 0.08,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: widget.project.accent.withValues(
                                        alpha: _hover ? 0.5 : 0.2,
                                      ),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_outward_rounded,
                                    size: 16,
                                    color: _hover
                                        ? widget.project.accent
                                        : AppColors.dim,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(width: 12),
                            Text(
                              '0${widget.index}',
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.dimmer,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.project.subtitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: widget.project.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Description
              Text(
                widget.project.description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: AppColors.dim,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),

              // Metrics Row
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  for (final m in widget.project.metrics)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.project.accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: widget.project.accent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt_rounded, size: 14, color: widget.project.accent),
                          const SizedBox(width: 4),
                          Text(
                            m,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (final t in widget.project.tags) TechTag(t),
                  if (_hasLink)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: widget.project.accent.withValues(
                          alpha: _hover ? 0.16 : 0.06,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: widget.project.accent.withValues(
                            alpha: _hover ? 0.5 : 0.25,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Project',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _hover
                                  ? widget.project.accent
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_outward_rounded,
                            size: 13,
                            color: _hover
                                ? widget.project.accent
                                : AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
