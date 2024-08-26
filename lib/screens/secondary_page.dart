import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotel1/providers/theme_provider.dart';

class SecondaryPage extends StatelessWidget {
  final String title;

  const SecondaryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme:
            IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
      ),
      body: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
