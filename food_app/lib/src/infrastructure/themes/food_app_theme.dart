import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: _primarySwatch(),
  scaffoldBackgroundColor: Colors.grey.shade200,
);

MaterialColor _primarySwatch() {
  return const MaterialColor(
    0xfff33f37,
  {
    050: Color(0xffffe9eb),
    100: Color(0xffffc8cb),
    200: Color(0xfff4928d),
    300: Color(0xffeb6660),
    400: Color(0xfff33f37),
    500: Color(0xfff62610),
    600: Color(0xffe81414),
    700: Color(0xffd7000f),
    800: Color(0xffca0005),
    900: Color(0xffbc0000),
  },
);
}
