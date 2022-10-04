import 'package:flutter/material.dart';

import '../utils/utils.dart';

ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: _primarySwatch(),
  scaffoldBackgroundColor: Colors.grey.shade200,
  textTheme: _textTheme(),
  inputDecorationTheme: _inputDecorationTheme(),
);

InputDecorationTheme _inputDecorationTheme() {
  return const InputDecorationTheme(
  isDense: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
    borderSide: BorderSide(width: 0.3),
  ),
  labelStyle: TextFormFieldUtils.textStyleSize20,
);
}

TextTheme _textTheme() {
  return const TextTheme(
  titleMedium: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
  ),
);
}


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
