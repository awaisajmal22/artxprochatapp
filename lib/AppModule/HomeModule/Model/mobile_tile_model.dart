import 'package:flutter/material.dart';

class MobileTileModel {
  String? title;
  IconData? icon;
  Function()? onTap;
  MobileTileModel({
    this.icon,
    this.title,
    this.onTap,
  });
}
