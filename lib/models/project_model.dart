import 'package:flutter/material.dart';

/// Featured project showcase item model.
class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final String role;
  final List<String> tags;
  final List<String> metrics;
  final Color accent;
  final IconData icon;
  final String? storeUrl;
  final String? url;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.role,
    required this.tags,
    required this.metrics,
    required this.accent,
    required this.icon,
    this.storeUrl,
    this.url,
  });

  /// The effective link URL to open, prioritizing [url] with fallback to [storeUrl].
  String? get linkUrl => (url != null && url!.trim().isNotEmpty) ? url : storeUrl;

  /// Whether this project has an associated link to visit.
  bool get hasLink => linkUrl != null && linkUrl!.trim().isNotEmpty;
}

