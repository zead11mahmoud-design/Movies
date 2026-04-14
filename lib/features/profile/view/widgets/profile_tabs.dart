import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/theme/app_theme.dart';

class ProfileTabs extends StatelessWidget {
  final String text;
  final int index;
  final int selectedTab;
  final VoidCallback onTap;
  final String iconName;

  const ProfileTabs({
    required this.text,
    required this.index,
    required this.selectedTab,
    required this.onTap,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: AppTheme.darkGray,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/$iconName.svg',
                width: 30,
                height: 20,
                colorFilter: ColorFilter.mode(AppTheme.primary, .srcIn),
              ),
              SizedBox(height: 5),
              Text(text, style: TextTheme.of(context).titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
