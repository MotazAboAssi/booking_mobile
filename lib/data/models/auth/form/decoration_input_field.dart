import 'package:booking/helper/constant/app_theme.dart';
import 'package:flutter/material.dart';

InputDecoration decorationInputFieldLogin({
  required String hintText,
  required String labelTeaxt,
  Widget? suffixIcon,
  required BuildContext context,
}) {
  return InputDecoration(
    // styles
    // Normal enabled border
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: context.appTheme.fourthly, width: 1.5),
    ),
    // Focused border
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: context.appTheme.fourthly, width: 2),
    ),
    // Error border
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: context.appTheme.error, width: 1.5),
    ),
    // Focused error border
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: context.appTheme.error, width: 2),
    ),

    suffixIconColor: context.appTheme.fourthly,

    // Label + hint colors
    labelStyle: TextStyle(color: context.appTheme.fourthly),
    hintStyle: TextStyle(color: context.appTheme.fourthly),

    // Error label
    errorStyle: TextStyle(color: context.appTheme.error),

    // props
    labelText: labelTeaxt,
    hintText: hintText,
    suffixIcon: suffixIcon,
  );
}
