import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../SizeConfig/size_config.dart';

toast(
    {required String title,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    ToastGravity gravity =ToastGravity.TOP,
    double fontSize = 16}) {
  return Fluttertoast.showToast(
    msg: title,
    backgroundColor: backgroundColor,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    textColor: textColor,
    fontSize: fontSize,
  );
}

void showSnackBar({
  required BuildContext context,
  required String title,
  Color textColor = Colors.white,
  Color backgroundColor = Colors.blue,
}) {
  final snackBar = SnackBar(
    content: Text(
      title,
      style: GoogleFonts.acme(
        color: textColor,
        fontSize: 14,
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    width: SizeConfig.widthMultiplier * 70,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
