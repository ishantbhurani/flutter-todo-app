import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;

  set brightness(Brightness brightness) {
    _brightness = brightness;
    notifyListeners();
  }

  bool isDarkMode() {
    return _brightness == Brightness.dark;
  }

  void toggleTheme() {
    brightness = isDarkMode() ? Brightness.light : Brightness.dark;
  }
}
