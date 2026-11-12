import 'package:flutter/material.dart';

/// Social channel contact link model.
class SocialLink {
  final String name;
  final String handle;
  final String url;
  final IconData icon;

  const SocialLink({
    required this.name,
    required this.handle,
    required this.url,
    required this.icon,
  });
}

