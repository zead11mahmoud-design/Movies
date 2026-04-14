import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFF6BD00);
  static const Color black = Color(0xFF121312);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF282A28);
  static const Color lightgray = Color(0xFFADADAD);
  static const Color darkGray = Color(0xFF212121);
  static const Color red = Color(0xFFE82626);
  static const Color green = Color(0xFF26E826);

  static ThemeData lightTheme = ThemeData();

  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    appBarTheme: AppBarThemeData(
      surfaceTintColor: Colors.transparent,
      backgroundColor: black,
      foregroundColor: primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
    ),
    scaffoldBackgroundColor: black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: gray,
      selectedItemColor: primary,
      unselectedItemColor: white,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: AppTheme.gray,

      hintStyle: TextStyle(fontSize: 16, fontWeight: .w400, color: white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: gray),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        color: white,
      ),
    ),
  );
}
