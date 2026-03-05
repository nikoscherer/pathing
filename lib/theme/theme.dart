import 'package:flutter/material.dart';

// ColorScheme colorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color.fromARGB(255, 77, 77, 77), 
//   onPrimary: Color.fromARGB(255, 32, 32, 32), 
//   secondary: Color.fromARGB(255, 77, 77, 125),
//   onSecondary: Color.fromARGB(255, 72, 72, 72), 
//   error: Color.fromARGB(255, 145, 18, 18), 
//   onError: Color.fromARGB(255, 0, 0, 0),
//   surface: Color.fromARGB(255, 70, 70, 70), 
//   onSurface: Color.fromARGB(255, 200, 200, 200)
// );

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF4A6CF7),
  brightness: Brightness.light,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 51, 0, 255),
  brightness: Brightness.dark,
);

TextTheme textTheme = TextTheme(
  titleSmall: TextStyle(
    fontSize: 12.0
  )
);

ButtonThemeData buttonThemeData = ButtonThemeData(
  textTheme: ButtonTextTheme.normal
);

ThemeData themeData = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: textTheme
);