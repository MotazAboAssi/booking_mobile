import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final IconData? icon;
  final String? title;
  const CardInfo({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rem(1.4)),
        border: BoxBorder.all(),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      // height: rem(2),
      child: ListTile(
        leading: Icon(icon),
        title: Center(child: Text(title ?? "null")),
      ),
    );
  }
}
