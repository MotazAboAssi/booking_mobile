import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  const CardInfo({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Center(child: Text(title)),
    );
  }
}
