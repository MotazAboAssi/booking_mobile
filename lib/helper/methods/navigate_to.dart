import 'package:flutter/material.dart';

void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
  bool routeExists = false;

  Navigator.of(context).popUntil((route) {
    if (route.settings.name == routeName &&
        route.settings.arguments == arguments) {
      routeExists = true;
      return true;
    }
    return false;
  });

  if (!routeExists) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }
}
