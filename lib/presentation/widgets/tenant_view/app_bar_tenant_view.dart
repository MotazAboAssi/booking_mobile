import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

AppBar appBarTenantView(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Icon(
        Icons.apartment,
        color: context.appTheme.primarye,
        size: rem(3),
      ),
    ),
    title: Text(
      'SYRent',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: context.appTheme.primarye,
      ),
    ),
    actionsPadding: const EdgeInsets.only(right: 10),

    actions: [
      Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              return Scaffold.of(context).openEndDrawer();
            },
            child: Stack(
              children: [
                Icon(Icons.notifications, size: rem(2), color: Colors.amber),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: context.appTheme.error,
                    minRadius: 5,
                    maxRadius: 8,
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: context.appTheme.thirdly,
                        fontSize: rem(0.45),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
