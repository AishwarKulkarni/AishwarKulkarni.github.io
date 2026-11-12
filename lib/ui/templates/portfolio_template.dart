import 'package:flutter/material.dart';

import '../atoms/space_canvas.dart';

/// Full-page portfolio template organizing background parallax, sticky navigation, and content sections.
class PortfolioTemplate extends StatelessWidget {
  const PortfolioTemplate({
    super.key,
    required this.spaceAnimation,
    required this.scrollController,
    required this.navigationBar,
    required this.sections,
  });

  final Animation<double> spaceAnimation;
  final ScrollController scrollController;
  final Widget navigationBar;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Parallax Stars
          Positioned.fill(
            child: CustomPaint(
              painter: SpaceCanvas(spaceAnimation, scrollController),
            ),
          ),

          // Main Scroll Area
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: sections,
            ),
          ),

          // Sticky Top Navigation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: navigationBar,
          ),
        ],
      ),
    );
  }
}

