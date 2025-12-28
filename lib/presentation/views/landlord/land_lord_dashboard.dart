import 'package:booking/presentation/widgets/Land%20Lord%20Dashboard/land_lord_dashboard_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:booking/presentation/widgets/Land Lord Dashboard/appbar_land_lord_dashboard.dart';
import 'package:booking/presentation/widgets/Land Lord Dashboard/body_land_lord_dashboard.dart';

class LandLordDashboard extends StatefulWidget {
  const LandLordDashboard({super.key});

  @override
  State<LandLordDashboard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LandLordDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarLandLordDashboard(),
      body: LandlordDashboard(),
      bottomNavigationBar: LandLordDashboardBottomNavigationBar(),
    );
  }
}
