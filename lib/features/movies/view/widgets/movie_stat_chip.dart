import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';

class MovieStatChip extends StatelessWidget {
  Widget icon;
  String text;

  MovieStatChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
      decoration: BoxDecoration(
        color: AppTheme.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 5),
          Text(text, style: TextTheme.of(context).titleLarge),
        ],
      ),
    );
  }
}
