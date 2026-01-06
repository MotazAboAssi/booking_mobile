import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/methods/to_capitalize.dart';
import 'package:flutter/material.dart';

class SectionLogoAndDescription extends StatelessWidget {
  const SectionLogoAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.apartment, size: rem(4), color: context.appTheme.fourthly),
        Text(
          toCapitalize("find your next home"),
          style: TextStyle(fontSize: rem(2), fontWeight: FontWeight.w900),
        ),
        Text(
          "How will you be using the app ?",
          style: TextStyle(color: context.appTheme.fourthly),
        ),
      ],
    );
  }
}
