import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/theme/app_theme.dart';

import '../../browse/view/browse_tab.dart';
import '../../home/view/home_tab.dart';
import '../../profile/view/profile_tab.dart';
import '../../search/view/search_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curruntIndex = 0;
  final List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[curruntIndex],
      backgroundColor: AppTheme.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curruntIndex,
        onTap: (index) {
          curruntIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg'),
            activeIcon: SvgPicture.asset('assets/icons/home-Filled.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/search.svg'),
            activeIcon: SvgPicture.asset('assets/icons/seach-filled.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/explore.svg'),
            activeIcon: SvgPicture.asset('assets/icons/explore-filled.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/Profile.svg'),
            activeIcon: SvgPicture.asset('assets/icons/Profile-filled.svg'),
            label: '',
          ),
        ],
      ),
    );
  }
}
