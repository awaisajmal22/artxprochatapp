import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomElevatedButton(
      {Key? key,  required this.title, required this.onPressed}) : super(key: key);

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
          backgroundColor: Colors.white,
          elevation: 10,
          shadowColor:
              isHovered ? Color(0xff3079E2) : Colors.grey.withOpacity(0.5),
        ),
        onPressed: () {
          widget.onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 16,
                  color: isHovered ? Color(0xff3079E2) : Colors.black54,
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
