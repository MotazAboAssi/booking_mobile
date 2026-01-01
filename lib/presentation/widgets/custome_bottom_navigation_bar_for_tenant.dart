import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomeBottomNavigationBarForTenant extends StatelessWidget {
  final int index;
  const CustomeBottomNavigationBarForTenant({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      disableDefaultTabController: true,
      backgroundColor: fourthly,
      items: [
        TabItem(icon: Icons.search, title: 'Search'),
        TabItem(icon: Icons.favorite, title: 'WishList'),
        TabItem(icon: Icons.card_travel, title: 'Booking'),
        TabItem(icon: Icons.person, title: 'Account'),
      ],
      onTap: (index) {
        if (index == 0) navigateTo(context, tenantView);
        if (index == 1) navigateTo(context, favoriteApartments);
        if (index == 2) navigateTo(context, mybooking);
        if (index == 3) navigateTo(context, profileViewTenant);
      },
      initialActiveIndex: index,
    );
  }
}
