import 'dart:io';

import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

Widget customFormField({
  required BuildContext context,
  required TextInputType keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool obsecureText = false,
  required String hintText,
  required TextEditingController controller,
  bool readOnly = false,
  int maxLines = 1,
  Function(String?)? onChange,
  double bottomPadding = 0.0,
}) {
  return Container(
    padding: EdgeInsets.only(bottom: bottomPadding),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
      BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(0.2), // Shadow color
        spreadRadius: 2, // Spread radius
        blurRadius: 5, // Blur radius
        offset: Offset(0, 3), // Offset in the x and y directions
      ),
    ]),
    child: TextFormField(
      readOnly: readOnly,
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Platform.isAndroid ? Colors.white : Colors.black,
          ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obsecureText,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Platform.isAndroid
            ? Theme.of(context).canvasColor.withOpacity(0.15)
            : Theme.of(context).primaryColor,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Platform.isAndroid ? Colors.white : Colors.black),
      ),
    ),
  );
}

Widget chatFormField(
    {required BuildContext context,
    required TextInputType keyboardType,
    TextInputAction textInputAction = TextInputAction.done,
    bool obsecureText = false,
    required String hintText,
    required TextEditingController controller,
    bool readOnly = false,
    int maxLines = 1,
    required Function(String) onChange,
    double bottomPadding = 0.0,
    double topPadding = 0.0,
    required VoidCallback attachFile,
    required VoidCallback cameraImage,
    required bool isShowCamera}) {
  return gradient(
    // padding: EdgeInsets.only(bottom: bottomPadding, top: topPadding),
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(20),
    topRightRadius: 20,
    bottomLeftRadius: 20,
    bottomRightRadius: 20,
    topleftRadius: 20,

    // ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: SizeConfig.widthMultiplier * 4,
          ),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                onChange(value);
              },
              minLines: 1,
              maxLines: 5,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              readOnly: readOnly,
              controller: controller,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Platform.isAndroid ? Colors.white : Colors.black,
                  ),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              obscureText: obsecureText,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(0),
                filled: true,
                fillColor: Platform.isAndroid
                    ? Colors.transparent
                    : Theme.of(context).primaryColor,
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Platform.isAndroid ? Colors.white : Colors.black),
              ),
            ),
          ),
          GestureDetector(
            onTap: attachFile,
            child: Icon(Ionicons.attach),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 4,
          ),
          isShowCamera == true
              ? GestureDetector(
                  onTap: cameraImage,
                  child: Icon(Ionicons.camera),
                )
              : SizedBox.shrink(),
          isShowCamera == true
              ? SizedBox(
                  width: SizeConfig.widthMultiplier * 4,
                )
              : SizedBox.shrink(),
        ],
      ),
    ),
  );
}

Widget customAddGroupFormField({
  required BuildContext context,
  required TextInputType keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool obsecureText = false,
  required String hintText,
  required TextEditingController controller,
}) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color
        spreadRadius: 2, // Spread radius
        blurRadius: 5, // Blur radius
        offset: Offset(0, 3), // Offset in the x and y directions
      ),
    ]),
    child: TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obsecureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Theme.of(context).primaryColor,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium,
      ),
    ),
  );
}

Widget customSearchFormField({
  required BuildContext context,
  required TextInputType keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool obsecureText = false,
  required String hintText,
  required TextEditingController controller,
  Function(String?)? onChanged,
  Color textColor = Colors.black,
}) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color
        spreadRadius: 2, // Spread radius
        blurRadius: 5, // Blur radius
        offset: Offset(0, 3), // Offset in the x and y directions
      ),
    ]),
    child: TextFormField(
      onChanged: (value) {
        onChanged!(value);
      },
      controller: controller,
      style:
          Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obsecureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Platform.isAndroid
            ? Theme.of(context).hoverColor
            : Theme.of(context).primaryColor,
        hintText: hintText,
        hintStyle:
            Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),
      ),
    ),
  );
}
