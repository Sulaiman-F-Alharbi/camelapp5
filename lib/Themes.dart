import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT }

final Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
final Mainbeige = const Color.fromRGBO(230, 203, 160, 1);

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Mainbrown,
    appBarTheme: AppBarTheme(
      color: Mainbrown,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Mainbeige,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    backgroundColor: Mainbeige,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Mainbrown,
        focusColor: Colors.blueAccent,
        splashColor: Colors.lightBlue),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Mainbeige),
  );
}
