import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/crew_palette.dart';
import '../models/manifest_role_entry.dart';
import '../models/project_model.dart';
import '../models/skill_category.dart';
import '../models/social_link.dart';

/// Static data sources for the portfolio application.
class PortfolioData {
  PortfolioData._();

  static const List<CrewPalette> palettes = [
    CrewPalette('Red', Color(0xFFE11D48), Color(0xFFBE123C)),
    CrewPalette('Cyan', Color(0xFF06B6D4), Color(0xFF0891B2)),
    CrewPalette('Emerald', Color(0xFF10B981), Color(0xFF059669)),
    CrewPalette('Blue', Color(0xFF3B82F6), Color(0xFF2563EB)),
    CrewPalette('Violet', Color(0xFF8B5CF6), Color(0xFF7C3AED)),
    CrewPalette('Amber', Color(0xFFF59E0B), Color(0xFFD97706)),
    CrewPalette('Pink', Color(0xFFEC4899), Color(0xFFDB2777)),
    CrewPalette('White', Color(0xFFE2E8F0), Color(0xFF94A3B8)),
  ];

  static const List<SkillCategory> skillCategories = [
    SkillCategory('Core & Architecture', Icons.architecture_rounded, P.blue, [
      'Flutter & Dart',
      'BLoC & Riverpod',
      'Clean Architecture',
      'Reusable UI & responsive layouts',
    ]),
    SkillCategory(
      'Mobile Systems & Platform',
      Icons.phone_android_rounded,
      P.green,
      [
        'Android & iOS development',
        'Firebase Auth & Firestore',
        'Push notifications',
        'Git & collaborative delivery',
      ],
    ),
    SkillCategory(
      'Cloud, Backend & Tooling',
      Icons.cloud_sync_rounded,
      P.purple,
      [
        'REST APIs & Dio',
        'FastAPI & PostgreSQL',
        'Python & SQL',
        'Stream Chat & Postman',
        'Figma & product collaboration',
      ],
    ),
  ];

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Sevaku',
      subtitle: 'Full Stack Service Marketplace',
      description: 'A service marketplace built with Flutter and FastAPI, connecting customers and providers with service discovery, bookings, profiles, and notifications.',
      role: 'Flutter & Backend Developer',
      tags: ['Flutter', 'FastAPI', 'PostgreSQL', 'REST APIs', 'Firebase'],
      metrics: [
        'Customer & Provider Apps',
        'Booking Workflow',
        'Push Notifications',
      ],
      accent: Color(0xFF3B82F6),
      icon: Icons.apartment_rounded,
      url: 'https://github.com/AishwarKulkarni',
    ),
    ProjectModel(
      title: 'WallOne - Financial AI Advisory',
      subtitle: 'Personal finance and investment companion',
      description: 'A personal finance app for expense tracking, budgeting, and investment monitoring. A rule-based recommendation engine surfaces personalized saving tips based on spending patterns, with charts and budget insights for a clear financial overview.',
      role: 'Flutter Developer',
      tags: ['Flutter', 'Provider', 'Finance', 'Recommendations', 'Charts'],
      metrics: ['Expense Tracking', 'Investment Monitoring', 'Budget Insights'],
      accent: Color(0xFFF59E0B),
      icon: Icons.account_balance_wallet_rounded,
      url: 'https://github.com/AishwarKulkarni',
    ),
    ProjectModel(
      title: 'Beat Bazaar',
      subtitle: 'Shazam inspired music recognition app',
      description: 'A cross-platform music app for song uploads, live playback, and cloud-synced listening data. Uses ACRCloud audio fingerprinting to identify songs from microphone input.',
      role: 'Flutter Developer',
      tags: ['Flutter', 'ACRCloud', 'Audio Fingerprinting', 'Cloud Sync'],
      metrics: ['Song Recognition', 'Live Playback', 'Listening History'],
      accent: Color(0xFF10B981),
      icon: Icons.graphic_eq_rounded,
      url: 'https://github.com/AishwarKulkarni',
    ),
  ];

  static const List<SocialLink> socialLinks = [
    SocialLink(
      name: 'GitHub',
      handle: '@AishwarKulkarni',
      url: 'https://github.com/AishwarKulkarni',
      icon: Icons.code_rounded,
    ),
    SocialLink(
      name: 'LinkedIn',
      handle: 'aishwar-kulkarni',
      url: 'https://www.linkedin.com/in/aishwar-kulkarni-19202325b',
      icon: Icons.business_center_rounded,
    ),
    SocialLink(
      name: 'Instagram',
      handle: '@aishwar_kulkarni',
      url: 'https://www.instagram.com/aishwar_kulkarni',
      icon: Icons.camera_alt_outlined,
    ),
    SocialLink(
      name: 'YouTube',
      handle: '@kasito',
      url: 'https://www.youtube.com/@kasito',
      icon: Icons.play_circle_outline_rounded,
    ),
    SocialLink(
      name: 'Email',
      handle: 'aishwarkulkarni@gmail.com',
      url: 'mailto:aishwarkulkarni@gmail.com',
      icon: Icons.mail_outline_rounded,
    ),
    SocialLink(
      name: 'Phone',
      handle: '+91 76235 57555',
      url: '+91 76235 57555',
      icon: Icons.phone_outlined,
    ),
  ];

  static const List<String> crewTransmissions = [
    'Task complete: 0 warnings, 0 compile errors.',
    'Scanning widget tree... No RenderFlex overflows found.',
    'Spotted in Electrical: fixing state management.',
    'Codebase inspected: 100% crewmate, not impostor.',
    'Pushing flavor builds to App Store Connect...',
  ];

  static const List<String> navLabels = [
    'Home',
    'Manifest',
    'Skills',
    'Projects',
    'Emergency Comms',
  ];

  static const List<ManifestRoleEntry> manifestRoles = [
    ManifestRoleEntry(
      icon: Icons.person_outline_rounded,
      label: 'Full Name',
      value: 'Aishwar Kulkarni',
    ),
    ManifestRoleEntry(
      icon: Icons.work_outline_rounded,
      label: 'Primary Role',
      value: 'Mobile App Engineer · Flutter Specialist',
    ),
    ManifestRoleEntry(
      icon: Icons.business_rounded,
      label: 'Current Station',
      value: 'PropTechBuzz (US Real Estate Tech Platform)',
    ),
    ManifestRoleEntry(
      icon: Icons.history_rounded,
      label: 'Prior Station',
      value: 'Qurinom Solutions (Hyderabad)',
    ),
    ManifestRoleEntry(
      icon: Icons.schedule_rounded,
      label: 'Experience',
      value: '2 years of hands-on Flutter development',
    ),
    ManifestRoleEntry(
      icon: Icons.public_rounded,
      label: 'Location',
      value: 'Vadodara, Gujarat, India · Open to remote',
    ),
  ];
}
