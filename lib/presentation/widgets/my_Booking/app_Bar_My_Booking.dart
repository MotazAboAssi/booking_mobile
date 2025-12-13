// import 'package:booking/helper/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:booking/helper/methods/rem.dart';

AppBar appBarMyBooking() {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_back)),
    ),
    title: Text("Add appartment", style: TextStyle(fontSize: rem(1))),
    centerTitle: true,
    actionsPadding: const EdgeInsets.only(right: 10),
    actions: [
      Stack(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 30)),
        ],
      ),
    ],
  );
}
