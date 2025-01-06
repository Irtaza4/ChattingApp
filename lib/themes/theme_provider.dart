import 'package:chattingapp/themes/dark_mode.dart';
import 'package:chattingapp/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkmode;

  set setThemeData(ThemeData themeData) {  // Changed the setter name here
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightmode) {
      setThemeData = darkmode;  // Use the renamed setter here
    } else {
      setThemeData = lightmode;  // Use the renamed setter here
    }
  }
}
