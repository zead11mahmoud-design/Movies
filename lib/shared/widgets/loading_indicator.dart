import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double rotation = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          rotation += 0.04;
          final scale = 0.8 + (0.4 * (0.5 + 0.5 * sin(rotation)));
          return Transform.rotate(
            angle: rotation,
            child: Transform.scale(scale: scale, child: child),
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primary, width: 5),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
