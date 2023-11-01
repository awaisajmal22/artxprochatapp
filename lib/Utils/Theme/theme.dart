import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff4E4FA2),
  brightness: Brightness.light,
  shadowColor: Colors.black38,
  canvasColor: Colors.black,
  inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      filled: true,
      iconColor: Colors.grey,
      fillColor: Colors.white,
      hintStyle: GoogleFonts.roboto(
        color: Colors.black45,
        fontSize: 16,
      )),
  dividerColor: Colors.white,
  drawerTheme: DrawerThemeData(
      backgroundColor: Colors.black,
      elevation: 20,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(50),
        topRight: Radius.circular(50),
      )),
      endShape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black45),
  indicatorColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  dialogBackgroundColor: Colors.white38,
  dialogTheme: DialogTheme(
    contentTextStyle: GoogleFonts.roboto(
      color: Colors.white,
    ),
    shadowColor: Color(0xff4E4FA2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.black,
    titleTextStyle: GoogleFonts.roboto(
      color: Colors.white,
    ),
    iconColor: Colors.black,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.white38,
    secondary: Colors.white,
    onSecondary: Colors.white38,
    error: Colors.white,
    onError: Colors.white38,
    background: Colors.white,
    onBackground: Colors.white38,
    surface: Colors.white,
    onSurface: Colors.white38,
  ),
  cardColor: Colors.black,
  focusColor: Colors.white,
  primaryColor: Colors.white,
  hoverColor: Colors.black,
  splashColor: Colors.white54,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        elevation: 10,
        shadowColor: Colors.black),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.roboto(
        color: Colors.black54,
        shadows: const [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black,
            offset: Offset(2, 0),
          ),
        ],
        // fontSize: 30,
        decoration: TextDecoration.lineThrough),
    bodyLarge: GoogleFonts.roboto(
      color: Colors.black54,
      // fontSize: 20,
    ),
    titleLarge: GoogleFonts.roboto(
      color: Colors.black,
      // fontSize: 20,
    ),
    titleSmall: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 16,
    ),
    displayMedium: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 20,
    ),
    titleMedium: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 18,
    ),
    bodyMedium: GoogleFonts.roboto(
      color: Colors.white,
      // fontSize: 20,
    ),
    headlineSmall: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 16,
      shadows: const [
        BoxShadow(
          blurRadius: 15,
          color: Colors.white,
          offset: Offset(2, 0),
        ),
      ],
    ),
    bodySmall: GoogleFonts.roboto(
      color: Colors.black,
    ),
  ),
);
