import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/services/shared_prefs_helper.dart';
import 'package:provider/provider.dart';

import '../../../core/services/firebase_service.dart';
import '../../../data/models/user_model.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../movies/view/home_screen.dart';
import '../../movies/view_model/movie_view_model.dart';
import '../../profile/view_model/history_view_model.dart';
import '../../profile/view_model/user_view_model.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = '/start';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    bool seenOnboarding = await SharedPrefsHelper.isOnboardingSeen();
    if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
      return;
    }
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      UserModel? user = await FirebaseService.getUser(firebaseUser.uid);
      Provider.of<UserViewModel>(
        context,
        listen: false,
      ).updateCurrentUser(user);
      Provider.of<MovieViewModel>(context, listen: false).favouriteMoviesList =
          user?.wishlist ?? [];
      Provider.of<WatchHistory>(context, listen: false).watchHistoryMoviesList =
          user?.history ?? [];
      Provider.of<MovieViewModel>(context, listen: false).notifyListeners();

      Provider.of<WatchHistory>(context, listen: false).notifyListeners();

      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LoadingIndicator()));
  }
}
