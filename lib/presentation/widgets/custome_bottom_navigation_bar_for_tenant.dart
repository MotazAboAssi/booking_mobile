import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
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
        TabItem(icon: Icons.search, title: TenantKeys.navSearch.tr()),
        TabItem(icon: Icons.favorite, title: TenantKeys.navWishlist.tr()),
        TabItem(icon: Icons.card_travel, title: TenantKeys.navBooking.tr()),
        TabItem(icon: Icons.person, title: TenantKeys.navAccount.tr()),
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
