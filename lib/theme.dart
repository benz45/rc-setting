import 'package:flutter/material.dart';

const Color customDarkPrimaryColor =
    Color.fromARGB(255, 97, 97, 97);
const Color customDarkAccentColor =
    Color.fromARGB(255, 209, 76, 76);
const Color customDarkBackgroundColor = Color.fromARGB(255, 31, 31, 31);
const Color customDarkSurfaceColor = Color(0xFF424242);
const Color customDarkTextColor = Color(0xFFFFFFFF);
const Color customDarkSuccessColor = Color.fromARGB(198, 105, 228, 105);
const Color customDarkGold = Color.fromARGB(255, 255, 213, 77);
const Color customDarkWarning = Color.fromARGB(207, 238, 197, 83);

const Color customBoxDetail = Color.fromARGB(255, 24, 24, 24);

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: customDarkPrimaryColor,
    hintColor: customDarkAccentColor,
    scaffoldBackgroundColor: customDarkBackgroundColor,
    cardColor: customDarkSurfaceColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: customDarkAccentColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: customDarkAccentColor,
        textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Kanit-Light'),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: customDarkAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
      ),
    ),
    fontFamily: 'Kanit-Light');
