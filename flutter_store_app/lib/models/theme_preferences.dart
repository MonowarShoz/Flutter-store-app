
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences{
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool val)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool(THEME_STATUS, val);

  }
  Future<bool> getTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(THEME_STATUS, ) ?? false;
  }
}