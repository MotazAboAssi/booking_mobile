import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomeBottomNavigationBarForTenant extends StatelessWidget {
  final int index;
  const CustomeBottomNavigationBarForTenant({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      disableDefaultTabController: true,
      backgroundColor: context.appTheme.fourthly,
      activeColor: context.appTheme.thirdly,
      color: context.appTheme.thirdly,

      items: [
        TabItem(icon: Icons.search, title: 'Search'),
        TabItem(icon: Icons.favorite, title: 'WishList'),
        TabItem(icon: Icons.card_travel, title: 'Booking'),
        TabItem(icon: Icons.person, title: 'Account'),
      ],
      onTap: (index) async {
        if (index == 0) {
          await Navigator.pushReplacementNamed(context, tenantView);
        } else if (index == 1) {
          await Navigator.pushReplacementNamed(context, favoriteApartments);
        } else if (index == 2) {
          await Navigator.pushReplacementNamed(context, mybooking);
        } else if (index == 3) {
          await Navigator.pushReplacementNamed(context, profileViewTenant);
        }
      },
      initialActiveIndex: index,
    );
  }
}
