import 'dart:io';

import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';

Widget imagePickerTile(
    {required String imageUrl, required VoidCallback voidCallback}) {
  return GestureDetector(
    onTap: voidCallback,
    child: Container(
      height: SizeConfig.heightMultiplier * 30,
      width: SizeConfig.widthMultiplier * 40,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(0, 8),
                blurRadius: 15),
          ],
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          image: imageUrl.isNotEmpty
              ? DecorationImage(
                  image: FileImage(
                    File(imageUrl),
                  ),
                  fit: BoxFit.cover)
              : const DecorationImage(
                  image: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/2815/2815428.png'),
                  fit: BoxFit.contain)),
    ),
  );
}
