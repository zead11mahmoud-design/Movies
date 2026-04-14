import 'package:flutter/material.dart';
import 'package:movies/core/services/shared_prefs_helper.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/features/auth/view/start_screen.dart';

import '../../../shared/widgets/defaulte_botton.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/OnBoarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> imagesName = [
    'OnBoarding_1',
    'OnBoarding_2',
    'OnBoarding_3',
    'OnBoarding_4',
    'OnBoarding_5',
    'OnBoarding_6',
  ];
  List<String> title = [
    'Find Your Next Favorite Movie Here',
    'Discover Movies',
    'Explore All Genres',
    'Create Watchlists',
    'Rate, Review, and Learn',
  ];
  List<String> description = [
    'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    'Share your thoughts on the movies youve watched. Dive deep into film details and help others discover great movies with your reviews.',
  ];
  int index = 0;

  void nextPage() async {
    if (index == 5) {
      await SharedPrefsHelper.setOnboardingSeen();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, StartScreen.routeName);
      return;
    }
    index++;
    setState(() {});
  }

  void backPage() {
    if (index == 0) return;
    index--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/${imagesName[index]}.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                right: 16,
                left: 16,
                top: 26,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                color: index == 0 ? Colors.transparent : AppTheme.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    index == 5 ? 'Start Watching Now' : title[index],
                    style: index == 0
                        ? textTheme.headlineSmall
                        : textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 10),
                  index == 5
                      ? SizedBox()
                      : Text(
                          description[index],
                          style: index == 0
                              ? textTheme.titleMedium!.copyWith(
                                  color: AppTheme.white.withValues(alpha: 0.6),
                                )
                              : textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),

                  SizedBox(height: 20),
                  DefaulteBotton(
                    text: index == 0
                        ? 'Explore Now'
                        : index == 5
                        ? 'Finish'
                        : 'Next',
                    onPressed: nextPage,
                  ),
                  SizedBox(height: 16),
                  index == 0
                      ? SizedBox()
                      : index == 1
                      ? SizedBox()
                      : DefaulteBotton(
                          text: 'Back',
                          onPressed: backPage,
                          border: 2,
                          colorBotton: AppTheme.black,
                          textColor: AppTheme.primary,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
