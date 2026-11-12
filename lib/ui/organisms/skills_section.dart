import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/skill_category.dart';
import '../molecules/section_header.dart';
import 'skill_category_card.dart';

/// Skills and technical proficiencies section organism displaying modular capability cards.
class SkillsSection extends StatelessWidget {
  const SkillsSection({
    super.key,
    required this.sectionKey,
    required this.categories,
  });

  final GlobalKey sectionKey;
  final List<SkillCategory> categories;

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
                tag: 'Arsenal // 02',
                title: 'Technical Tasks & Proficiencies',
                subtitle:
                    'Engineered competencies continuously refined through production releases, PR code reviews, and performance optimization.',
                tagColor: AppColors.green,
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (_, box) {
                  final cols = box.maxWidth > 900 ? 3 : (box.maxWidth > 600 ? 2 : 1);
                  final cardWidth = (box.maxWidth - 20.0 * (cols - 1)) / cols;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 24,
                    children: [
                      for (final category in categories)
                        SizedBox(
                          width: cardWidth,
                          child: SkillCategoryCard(category: category),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

