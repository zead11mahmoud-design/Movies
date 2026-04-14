import 'package:flutter/material.dart';
import 'package:movies/features/profile/view/widgets/profile_header.dart';
import 'package:movies/features/profile/view/widgets/wishlist_tabs.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Column(
      children: [
        ProfileHeader(),
        Expanded(child: WatchHistoryTabs()),
      ],
    );
  }
}
