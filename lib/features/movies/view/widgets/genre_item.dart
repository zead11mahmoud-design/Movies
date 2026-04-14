import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';

class GenreItem extends StatelessWidget {
  String text;

  GenreItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleSmall!.copyWith(color: Colors.white),
      ),
    );
  }
}
