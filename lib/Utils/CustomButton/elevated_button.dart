import 'dart:ffi';

import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  Color? backgroundColor;
  Color? textColor;
  double? fontSize;
  double verticalPadding;
  CustomElevatedButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.textColor = Colors.black54,
      this.fontSize,
      this.verticalPadding = 10,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onHover: (value) {
          setState(() {
            isHovered = value;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          elevation: 10,
          shadowColor:
              isHovered ? Color(0xff3079E2) : Colors.grey.withOpacity(0.5),
        ),
        onPressed: () {
          widget.onPressed();
        },
        child: Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: 10, vertical: widget.verticalPadding),
          child: Center(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: widget.fontSize == null
                      ? SizeConfig.textMultiplier * 2.5
                      : widget.fontSize,
                  color: isHovered ? Color(0xff3079E2) : widget.textColor,
                  shadows: [
                    isHovered
                        ? const BoxShadow(
                            blurRadius: 15,
                            color: Color(0xff3079E2),
                            offset: Offset(2, 0),
                          )
                        : const BoxShadow(
                            blurRadius: 15,
                            color: Colors.black,
                            offset: Offset(2, 0),
                          ),
                  ]),
            ),
          ),
        ));
  }
}
