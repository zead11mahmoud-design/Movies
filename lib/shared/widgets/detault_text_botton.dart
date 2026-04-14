import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';

class DetaultTextBotton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color? color = AppTheme.primary;

  DetaultTextBotton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: color)),
    );
  }
}
