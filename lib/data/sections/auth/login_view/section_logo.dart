import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class SectionLogo extends StatelessWidget {
  const SectionLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(Icons.apartment, color: context.appTheme.thirdly, size: rem(6))],
    );
  }
}
