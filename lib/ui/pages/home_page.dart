import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/portfolio_data.dart';
import '../organisms/emergency_contact_section.dart';
import '../organisms/emergency_meeting_dialog.dart';
import '../organisms/footer.dart';
import '../organisms/hero_section.dart';
import '../organisms/manifest_section.dart';
import '../organisms/navigation_bar.dart';
import '../organisms/projects_section.dart';
import '../organisms/skills_section.dart';
import '../templates/portfolio_template.dart';

/// Home page managing user interactions, scroll tracking, and dynamic state.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _spaceController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 120),
  )..repeat();

  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());

  final ValueNotifier<double> _scrollProgress = ValueNotifier<double>(0);
  final ValueNotifier<int> _activeSection = ValueNotifier<int>(0);

  int _selectedColorIndex = 0;
  int _transmissionIndex = 0;
  Timer? _transmissionTimer;
  bool _navScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());

    _transmissionTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) {
        setState(() {
          _transmissionIndex =
              (_transmissionIndex + 1) % PortfolioData.crewTransmissions.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _transmissionTimer?.cancel();
    _spaceController.dispose();
    _scrollController.dispose();
    _scrollProgress.dispose();
    _activeSection.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!mounted) return;
    if (_scrollController.hasClients) {
      final max = _scrollController.position.maxScrollExtent;
      _scrollProgress.value =
          max > 0 ? (_scrollController.offset / max).clamp(0.0, 1.0) : 0;
      final scrolled = _scrollController.offset > 24;
      if (scrolled != _navScrolled) {
        setState(() => _navScrolled = scrolled);
      }
    }

    final vh = MediaQuery.of(context).size.height;
    var currentActive = 0;
    for (var i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final dy =
          (ctx.findRenderObject() as RenderBox).localToGlobal(Offset.zero).dy;
      if (dy < vh * 0.45) currentActive = i;
    }
    _activeSection.value = currentActive;
  }

  void _scrollToSection(int index) {
    if (index < 0 || index >= _sectionKeys.length) return;
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _triggerEmergencyMeeting() {
    HapticFeedback.heavyImpact();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.85),
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (_, _, _) => const EmergencyMeetingDialog(),
      transitionBuilder: (_, anim, _, child) {
        final curved =
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final activeColor = PortfolioData.palettes[_selectedColorIndex].primary;

    return PortfolioTemplate(
      spaceAnimation: _spaceController,
      scrollController: _scrollController,
      navigationBar: PortfolioNavigationBar(
        isMobile: isMobile,
        isScrolled: _navScrolled,
        activeColor: activeColor,
        navLabels: PortfolioData.navLabels,
        activeSection: _activeSection,
        scrollProgress: _scrollProgress,
        onNavigate: _scrollToSection,
        onEmergencyMeeting: _triggerEmergencyMeeting,
      ),
      sections: [
        HeroSection(
          sectionKey: _sectionKeys[0],
          screenSize: screenSize,
          isMobile: isMobile,
          isTablet: isTablet,
          activeColor: activeColor,
          palettes: PortfolioData.palettes,
          selectedColorIndex: _selectedColorIndex,
          transmissionMessage:
              PortfolioData.crewTransmissions[_transmissionIndex],
          transmissionIndex: _transmissionIndex,
          socialLinks: PortfolioData.socialLinks,
          onExploreProjects: () => _scrollToSection(3),
          onViewResume: () => _scrollToSection(1),
          onCycleColor: () {
            setState(() {
              _selectedColorIndex =
                  (_selectedColorIndex + 1) % PortfolioData.palettes.length;
            });
          },
          onSelectColor: (idx) => setState(() => _selectedColorIndex = idx),
        ),
        ManifestSection(
          sectionKey: _sectionKeys[1],
          isMobile: isMobile,
        ),
        SkillsSection(
          sectionKey: _sectionKeys[2],
          categories: PortfolioData.skillCategories,
        ),
        ProjectsSection(
          sectionKey: _sectionKeys[3],
          projects: PortfolioData.projects,
          isMobile: isMobile,
        ),
        EmergencyContactSection(
          sectionKey: _sectionKeys[4],
          spaceAnimation: _spaceController,
          onTriggerEmergencyMeeting: _triggerEmergencyMeeting,
        ),
        PortfolioFooter(activeColor: activeColor),
      ],
    );
  }
}
