import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static late final SharedPreferences prefs;

  static late Brightness _brightness;

  static const themePrefKey = 'isDarkTheme';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool(themePrefKey) ?? false;
    _brightness = isDarkTheme ? Brightness.dark : Brightness.light;
  }

  Brightness get brightness => _brightness;

  set brightness(Brightness brightness) {
    _brightness = brightness;
    prefs.setBool(themePrefKey, isDarkMode());
    notifyListeners();
  }

  bool isDarkMode() {
    return _brightness == Brightness.dark;
  }

  void toggleTheme() {
    brightness = isDarkMode() ? Brightness.light : Brightness.dark;
  }
}
