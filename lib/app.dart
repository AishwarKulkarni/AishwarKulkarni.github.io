import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'ui/pages/home_page.dart';

/// Root application widget configuring theme, localization, and main route.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aishwar Kulkarni | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}

