import 'package:flutter/material.dart';

class AppTheme {
  static const seedColor = Color(0xFF4A6CF7);

  static final textTheme = TextTheme(
    titleMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500
    )
  );

  static final dropdownMenuTheme = DropdownMenuThemeData(
    inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),

    menuStyle: MenuStyle(
      elevation: WidgetStatePropertyAll(4),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )
    )
  );

  static final inputDecorationTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: .light
    ),

    textTheme: textTheme,
    dropdownMenuTheme: dropdownMenuTheme,
    inputDecorationTheme: inputDecorationTheme
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: .dark
    ),

    textTheme: textTheme,
    dropdownMenuTheme: dropdownMenuTheme,
    inputDecorationTheme: inputDecorationTheme
  );
}