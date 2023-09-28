import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemeType {
  lightTheme,
  darkTheme,
}

final appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  shadowColor: Colors.black38,
  canvasColor: Colors.black,
  inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      filled: true,
      iconColor: Colors.white,
      fillColor: Colors.white,
      hintStyle: GoogleFonts.lilitaOne(
        color: Colors.black45,
        fontSize: 16,
      )),
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
    contentTextStyle: GoogleFonts.lilitaOne(
      color: Colors.white,
    ),
    shadowColor: Colors.black38,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.black,
    titleTextStyle: GoogleFonts.lilitaOne(
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
  cardTheme: const CardTheme(
      color: Colors.black,
      elevation: 20,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ))),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.acme(
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
    bodyLarge: GoogleFonts.acme(
      color: Colors.black54,
      // fontSize: 20,
    ),
    titleLarge: GoogleFonts.acme(
      color: Colors.white,
      // fontSize: 20,
    ),
    titleSmall: GoogleFonts.lilitaOne(
      color: Colors.white,
      fontSize: 16,
    ),
    displayMedium: GoogleFonts.lilitaOne(
      color: Colors.white,
      fontSize: 20,
    ),
    titleMedium: GoogleFonts.lilitaOne(
      color: Colors.black,
      // fontSize: 20,
    ),
    bodyMedium: GoogleFonts.acme(
      color: Colors.black54,
      // fontSize: 20,
    ),
    headlineSmall: GoogleFonts.lilitaOne(
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
    bodySmall: GoogleFonts.lilitaOne(
      color: Colors.black,
    ),
  ),
);
//   ThemeType.darkTheme: ThemeData(
//       scaffoldBackgroundColor: Colors.transparent,
//       brightness: Brightness.dark,
//       shadowColor: Colors.white38,
//       canvasColor: Colors.white,
//       inputDecorationTheme: InputDecorationTheme(
//           border: InputBorder.none,
//           filled: true,
//           iconColor: Colors.black,
//           fillColor: Colors.black,
//           hintStyle: GoogleFonts.lilitaOne(
//             color: Colors.white,
//             fontSize: 16,
//           )),
//       drawerTheme: DrawerThemeData(
//           backgroundColor: Colors.white,
//           elevation: 20,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(50),
//             topRight: Radius.circular(50),
//           )),
//           endShape: BeveledRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           shadowColor: Colors.white38),
//       indicatorColor: Colors.black,
//       iconTheme: const IconThemeData(
//         color: Colors.black,
//       ),
//       dialogBackgroundColor: Colors.black45,
//       dialogTheme: DialogTheme(
//         contentTextStyle: GoogleFonts.lilitaOne(
//           color: Colors.black,
//         ),
//         shadowColor: Colors.white38,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         backgroundColor: Colors.white,
//         titleTextStyle: GoogleFonts.lilitaOne(
//           color: Colors.black,
//         ),
//         iconColor: Colors.white,
//       ),
//       colorScheme: const ColorScheme(
//         brightness: Brightness.dark,
//         primary: Colors.black,
//         onPrimary: Colors.black45,
//         secondary: Colors.black,
//         onSecondary: Colors.black45,
//         error: Colors.black,
//         onError: Colors.black45,
//         background: Colors.black,
//         onBackground: Colors.black45,
//         surface: Colors.black,
//         onSurface: Colors.black45,
//       ),
//       cardColor: Colors.white,
//       focusColor: Colors.black,
//       primaryColor: Colors.black,
//       hoverColor: Colors.black,
//       splashColor: Colors.black45,
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             foregroundColor: Colors.black,
//             backgroundColor: Colors.white,
//             elevation: 10,
//             shadowColor: Colors.white),
//       ),
//       cardTheme: const CardTheme(
//           color: Colors.white,
//           elevation: 20,
//           shadowColor: Colors.white38,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(50),
//             bottomLeft: Radius.circular(50),
//           ))),
//       textTheme: TextTheme(
//           headlineLarge: GoogleFonts.acme(
//               color: Colors.white54,
//               shadows: const [
//                 BoxShadow(
//                   blurRadius: 15,
//                   color: Colors.white,
//                   offset: Offset(2, 0),
//                 ),
//               ],
//               // fontSize: 30,
//               decoration: TextDecoration.lineThrough),
//           bodyLarge: GoogleFonts.acme(
//             color: Colors.white54,
//             // fontSize: 20,
//           ),
//           titleLarge: GoogleFonts.acme(
//             color: Colors.black,
//             // fontSize: 20,
//           ),
//           headlineSmall: GoogleFonts.lilitaOne(
//               color: Colors.black,
//               fontSize: 16,
//               shadows: const [
//                 BoxShadow(
//                   blurRadius: 15,
//                   color: Colors.black45,
//                   offset: Offset(2, 0),
//                 ),
//               ]),
//           titleSmall: GoogleFonts.lilitaOne(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//           displayMedium: GoogleFonts.lilitaOne(
//             color: Colors.black,
//             fontSize: 20,
//           ),
//           titleMedium: GoogleFonts.lilitaOne(
//             color: Colors.white,
//             // fontSize: 20,
//           ),
//           bodyMedium: GoogleFonts.acme(
//             color: Colors.white54,
//             // fontSize: 20,
//           ),
//           bodySmall: GoogleFonts.lilitaOne(
//             color: Colors.white,
//           ))),
// };

// final appGradient = {
//   ThemeType.lightTheme: const LinearGradient(
//     colors: [
//       Colors.white,
//       Colors.white,
//     ],
//     // transform: GradientRotation(50),
//   ),
//   ThemeType.darkTheme: const LinearGradient(
//     colors: [
//       Colors.black,
//       Colors.black,
//     ],
//     // transform: GradientRotation(50),
//   ),
// };