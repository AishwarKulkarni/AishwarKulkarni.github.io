import 'package:flutter/material.dart';

/// Skill domain representation grouped by technical area.
class SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;

  const SkillCategory(this.title, this.icon, this.color, this.skills);
}

