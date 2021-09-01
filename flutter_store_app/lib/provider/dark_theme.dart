import 'package:flutter/material.dart';
import 'package:flutter_store_app/models/theme_preferences.dart';

class DarkThemeProvider with ChangeNotifier{
  ThemePreferences themePreferences = ThemePreferences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme (bool val){
    _darkTheme = val;
    themePreferences.setDarkTheme(val);
    notifyListeners();
  }

}