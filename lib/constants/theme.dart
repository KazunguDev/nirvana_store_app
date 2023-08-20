import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  inputDecorationTheme: InputDecorationTheme(

    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    prefixIconColor: Colors.blueGrey,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  scaffoldBackgroundColor: Colors.blue[100],
  primaryColor: Colors.red,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.lightBlueAccent
        ),
        foregroundColor: Colors.blue,
        disabledBackgroundColor: Colors.blue.withOpacity(0.38),
        side: const BorderSide(color: Colors.blueAccent,width: 2),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[400],
        disabledBackgroundColor: Colors.pink,
        textStyle:  const TextStyle(
          fontSize: 18,
        )),
  ),
  primarySwatch: Colors.blue,
  canvasColor: Colors.cyan,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.lightBlueAccent,
    elevation: 0.0,
    toolbarTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  )
);
OutlineInputBorder outlineInputBorder = const OutlineInputBorder
  (borderSide: BorderSide(color: Colors.black),);