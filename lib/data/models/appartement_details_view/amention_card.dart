import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class AmentionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double fontSize;
  final double iconsSize;
  const AmentionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.fontSize,
    required this.iconsSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.appTheme.primary),
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, size: rem(iconsSize), color: context.appTheme.fourthly),
        trailing: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth * 0.6,
              child: Center(
                child: Text(title, style: TextStyle(fontSize: rem(fontSize))),
              ),
            );
          },
        ),
      ),
    );
  }
}
