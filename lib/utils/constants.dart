import 'package:flutter/material.dart';

class AppColors {

  // -- main colors --
  static const primary = Color(0xFF3B30);
  static const primaryAccent = Color(0xFF453A);

  // -- backgrounds --
  static const background = Color(0x0F0F0F);
  static const background_op = Color(0x1C1C1E);

  // -- text --
  static const main_text = Color(0xEFEFF4);
  static const secondary_text = Color(0x8E8E93);

  // error & support
  static const error = Colors.red;
  static const success = Color.fromARGB(0, 25, 241, 72);
  static const warning = Color.fromARGB(0, 238, 220, 25);
  static const info = Color.fromARGB(0, 9, 114, 213);

  // -- theme --
  ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,

      // -- color scheme --
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primaryAccent,
        surface: background_op,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: main_text,
        onError: Colors.black
      ),
    );
  }

}