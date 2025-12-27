import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class ButtonRefresh extends StatelessWidget {
  final VoidCallback action;
  const ButtonRefresh({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: EdgeInsets.only(bottom: rem(0.5)),
        child: CircleAvatar(
          backgroundColor: fourthly,
          child: Icon(Icons.refresh, color: thirdly),
        ),
      ),
    );
  }
}
