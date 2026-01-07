import 'package:booking/helper/constant/app_theme.dart';
import 'package:flutter/material.dart';

AppBar appBarTenantView(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CircleAvatar(backgroundColor: context.appTheme.primary),
    ),
    title: Text("title app"),
    actionsPadding: const EdgeInsets.only(right: 10),

    actions: [
      Stack(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, size: 30),
          ),
          Positioned(
            right: 7,
            top: 7,
            child: CircleAvatar(
              backgroundColor: context.appTheme.primary,
              minRadius: 5,
              maxRadius: 8,
              child: Text(
                "99+",
                style: TextStyle(color: context.appTheme.thirdly, fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
