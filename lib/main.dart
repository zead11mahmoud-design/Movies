import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'features/auth/view/forgot_password_screen.dart';
import 'features/auth/view/login_screen.dart';
import 'features/auth/view/onboarding_screen.dart';
import 'features/auth/view/register_screen.dart';
import 'features/auth/view/start_screen.dart';
import 'features/auth/view_model/auth_view_model.dart';
import 'features/movies/view/home_screen.dart';
import 'features/movies/view_model/movie_view_model.dart';
import 'features/profile/view/edit_profile.dart';
import 'features/profile/view_model/history_view_model.dart';
import 'features/profile/view_model/user_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => MovieViewModel()),
        ChangeNotifierProvider(create: (_) => WatchHistory()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (_) => StartScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        EditProfile.routeName: (_) => EditProfile(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
