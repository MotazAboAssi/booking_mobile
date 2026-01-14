import 'package:booking/presentation/widgets/custome_bottom_navigation_bar_for_landlord.dart';
import 'package:flutter/material.dart';
import 'package:booking/presentation/widgets/Land Lord Dashboard/appbar_land_lord_dashboard.dart';
import 'package:booking/presentation/widgets/Land Lord Dashboard/body_land_lord_dashboard.dart';

class LandLordDashboard extends StatelessWidget {
  const LandLordDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarLandLordDashboard(context),
      body: LandlordDashboard(),
      bottomNavigationBar: CustomeBottomNavigationBarForLandlord(index: 0),
    );
  }
}
