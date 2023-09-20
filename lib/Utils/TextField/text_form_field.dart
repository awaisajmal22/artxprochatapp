import 'package:flutter/material.dart';

Widget customFormField({
  required BuildContext context,
  required TextInputType keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool obsecureText = false,
  required String hintText,
  required TextEditingController controller,
  bool readOnly = false,
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
      readOnly: readOnly,
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

Widget customAddGroupFormField(
    {required BuildContext context,
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
