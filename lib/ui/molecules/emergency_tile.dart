import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../atoms/crew.dart';

/// Interactive emergency channel tile molecule allowing quick link opening or phone number copying.
class EmergencyTile extends StatefulWidget {
  const EmergencyTile({
    super.key,
    required this.color,
    required this.name,
    required this.handle,
    required this.url,
    required this.icon,
  });

  final Color color;
  final String name;
  final String handle;
  final String url;
  final IconData icon;

  @override
  State<EmergencyTile> createState() => _EmergencyTileState();
}

class _EmergencyTileState extends State<EmergencyTile> {
  bool _copied = false;
  bool _hover = false;

  bool get _isPhone => widget.name.trim().toLowerCase() == 'phone';

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
        debugPrint('Could not launch emergency channel url: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtitleText = _copied ? 'Copied number!' : widget.handle;

    final tooltipMessage = _isPhone
        ? 'Click to copy phone number'
        : (widget.name.toLowerCase() == 'email'
            ? 'Send email'
            : 'Open ${widget.name}');

    return Tooltip(
      message: tooltipMessage,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: _handleTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 240,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _copied
                  ? AppColors.green.withValues(alpha: 0.18)
                  : (_hover ? AppColors.panelElevated : AppColors.surface),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _copied
                    ? AppColors.green
                    : (_hover ? widget.color : AppColors.borderSubtle),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Crew(color: _copied ? AppColors.green : widget.color, height: 44),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitleText,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jetBrainsMono(
                          color: _copied ? AppColors.green : AppColors.dim,
                          fontSize: 11,
                          fontWeight:
                              _copied ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _copied
                      ? Icons.check_circle_rounded
                      : (_hover && !_isPhone
                          ? Icons.arrow_outward_rounded
                          : widget.icon),
                  size: 18,
                  color: _copied
                      ? AppColors.green
                      : (_hover ? widget.color : AppColors.dimmer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
