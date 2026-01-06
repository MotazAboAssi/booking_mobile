import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/methods/to_capitalize.dart';
import 'package:flutter/material.dart';

class RoleCardModel extends StatelessWidget {
  final IconData icon;
  final String role;
  final String permissions;

  const RoleCardModel({
    super.key,
    required this.icon,
    required this.role,
    required this.permissions,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, registerView, arguments: {"role": role});
      },
      borderRadius: BorderRadius.circular(rem(1.4)),
      child: Container(
        padding: EdgeInsets.all(rem(1.5)),
        decoration: BoxDecoration(
          color: context.appTheme.thirdly,
          borderRadius: BorderRadius.circular(rem(1.4)),
          border: Border.all(color: context.appTheme.fourthly),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: rem(2), color: context.appTheme.fourthly),
            Text(
              "I'm a ${toCapitalize(role)}",
              style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
            ),
            Text(
              permissions,
              style: TextStyle(
                fontSize: rem(1),
                color: context.appTheme.fourthly,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
