import 'package:flutter/material.dart';

void customSnakBar({
  required BuildContext context,
  required Color color,
  required String message,
  EdgeInsetsGeometry? margin
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: margin,      
      duration: Duration(seconds: 5),
      backgroundColor: color,
      content: Text(message, style: TextStyle(fontSize: 20)),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
  );
}
