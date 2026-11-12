import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/project_model.dart';
import '../molecules/section_header.dart';
import 'project_showcase_card.dart';

/// Featured missions and project showcase section organism.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({
    super.key,
    required this.sectionKey,
    required this.projects,
    required this.isMobile,
    this.onProjectTap,
  });

  final GlobalKey sectionKey;
  final List<ProjectModel> projects;
  final bool isMobile;
  final void Function(ProjectModel project)? onProjectTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                tag: 'Missions // 03',
                title: 'Featured Projects',
                subtitle:
                    'Real-world software built with scalability, high fidelity, and deliberate user experience.',
                tagColor: AppColors.purple,
              ),
              const SizedBox(height: 40),
              for (var i = 0; i < projects.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: ProjectShowcaseCard(
                    project: projects[i],
                    index: i + 1,
                    isMobile: isMobile,
                    onTap: onProjectTap != null
                        ? () => onProjectTap!(projects[i])
                        : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

