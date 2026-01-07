import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomeBottomNavigationBarForLandlord extends StatelessWidget {
  final int index;
  const CustomeBottomNavigationBarForLandlord({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      disableDefaultTabController: true,
      backgroundColor: context.appTheme.fourthly,
      activeColor: context.appTheme.thirdly,
      color: context.appTheme.thirdly,

      items: [
        TabItem(icon: Icons.dashboard, title: 'Home'),
        // TabItem(icon: Icons.card_travel, title: 'Booking'),
        TabItem(icon: Icons.person, title: 'Account'),
      ],
      onTap: (index) {
        if (index == 0) navigateTo(context, landlordDashBoard);
        // if (index == 1) navigateTo(context, addApartment);
        if (index == 1) navigateTo(context, profileViewLandLord);
      },
      initialActiveIndex: index,
    );
  }
}
