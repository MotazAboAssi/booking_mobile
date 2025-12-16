import 'package:flutter/material.dart';

class TextResponse extends StatelessWidget {
  final String input;
  final TextStyle style;

  const TextResponse(this.input, {super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(input, style: style);
  }
}
