import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Color _buttonColor = Colors.red;

  ThemeMode get themeMode => _themeMode;
  Color get buttonColor => _buttonColor;

  void toggleTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleButtonColor(Color color) {
    _buttonColor = color;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      );

  ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      );
}
