import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../models/social_link.dart';

/// Interactive social link pill molecule that launches links or copies phone numbers.
class SocialPill extends StatefulWidget {
  const SocialPill({
    super.key,
    required this.icon,
    required this.label,
    required this.handle,
    required this.url,
  });

  factory SocialPill.fromModel(SocialLink model) {
    return SocialPill(
      icon: model.icon,
      label: model.name,
      handle: model.handle,
      url: model.url,
    );
  }

  final IconData icon;
  final String label;
  final String handle;
  final String url;

  @override
  State<SocialPill> createState() => _SocialPillState();
}

class _SocialPillState extends State<SocialPill> {
  bool _hover = false;
  bool _copied = false;

  bool get _isPhone => widget.label.trim().toLowerCase() == 'phone';

  Future<void> _handleTap() async {
    if (_isPhone) {
      await Clipboard.setData(ClipboardData(text: widget.url));
      if (!mounted) return;
      setState(() => _copied = true);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) setState(() => _copied = false);
      return;
    }

    var formatted = widget.url.trim();
    if (formatted.contains('@') &&
        !formatted.startsWith('mailto:') &&
        !formatted.startsWith('http')) {
      formatted = 'mailto:$formatted';
    } else if (!formatted.startsWith('http://') &&
        !formatted.startsWith('https://') &&
        !formatted.startsWith('mailto:')) {
      formatted = 'https://$formatted';
    }

    final uri = Uri.tryParse(formatted);
    if (uri != null) {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint('Could not launch social link: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _copied
        ? 'Copied!'
        : (widget.label == 'Email' || widget.label == 'Phone'
            ? widget.handle
            : widget.label);

    final tooltipMessage = _isPhone
        ? 'Click to copy phone number'
        : (widget.label.toLowerCase() == 'email'
            ? 'Send email'
            : 'Open ${widget.label}');

    return Tooltip(
      message: tooltipMessage,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: _handleTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _copied
                  ? AppColors.green.withValues(alpha: 0.18)
                  : (_hover
                      ? AppColors.panelElevated
                      : AppColors.surface.withValues(alpha: 0.6)),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _copied
                    ? AppColors.green
                    : (_hover ? AppColors.borderBright : AppColors.borderSubtle),
                width: 1.1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _copied ? Icons.check_circle_rounded : widget.icon,
                  size: 15,
                  color: _copied
                      ? AppColors.green
                      : (_hover ? AppColors.text : AppColors.dim),
                ),
                const SizedBox(width: 8),
                Text(
                  displayText,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _copied
                        ? AppColors.green
                        : (_hover ? AppColors.text : AppColors.textSecondary),
                  ),
                ),
                if (!_isPhone) ...[
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_outward_rounded,
                    size: 12,
                    color: _hover ? AppColors.text : AppColors.dimmer,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
