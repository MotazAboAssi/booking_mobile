import 'package:booking/helper/constant/theme.dart';
import 'package:flutter/material.dart';

InputDecoration decorationInputFieldLogin({
  required String hintText,
  required String labelTeaxt,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    // styles
    // Normal enabled border
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: fourthly, width: 1.5),
    ),
    // Focused border
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: fourthly, width: 2),
    ),
    // Error border
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),
    // Focused error border
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),

    suffixIconColor: fourthly,

    // Label + hint colors
    labelStyle: TextStyle(color: fourthly),
    hintStyle: TextStyle(color: fourthly.shade200),

    // Error label
    errorStyle: TextStyle(color: Colors.red),

    // props
    labelText: labelTeaxt,
    hintText: hintText,
    suffixIcon: suffixIcon,
  );
}
