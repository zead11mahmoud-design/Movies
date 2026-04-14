import 'package:flutter/cupertino.dart';

class SettingsProvider with ChangeNotifier {
  String languageCode = 'en';

  void changeLanguage(String language) async {
    if (languageCode == language) return;

    languageCode = language;
    notifyListeners();
  }
}
