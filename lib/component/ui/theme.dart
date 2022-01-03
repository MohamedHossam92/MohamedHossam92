import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';

ThemeData myTheme = ThemeData(
  primaryColor: cLogoColor,
  fontFamily: 'Almarai',
  iconTheme: IconThemeData(color: Colors.black),

  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(cLogoColorW),
  ),

  //
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: cLogoColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: cLogoColor,
          ),
          borderRadius: BorderRadius.circular(10))),
//
  //
  appBarTheme: AppBarTheme(
    color: cLogoColor,
  ),
//
// //

  checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      checkColor: MaterialStateProperty.all(Colors.white),
      side: BorderSide(width: 1),
      fillColor: MaterialStateProperty.all(cLogoColorW)),
);
