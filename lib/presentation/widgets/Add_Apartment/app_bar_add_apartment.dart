// import 'package:booking/helper/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:booking/helper/methods/rem.dart';

AppBar addApartmentAppBar(BuildContext context) {
  return AppBar(
    leading:Container(),
    title: Text("Add appartment", style: TextStyle(fontSize: rem(1))),
    centerTitle: true,
  );
}
