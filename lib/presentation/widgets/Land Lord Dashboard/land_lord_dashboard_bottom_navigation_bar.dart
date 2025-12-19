import 'package:flutter/material.dart';

class LandLordDashboardBottomNavigationBar extends StatefulWidget {
  const LandLordDashboardBottomNavigationBar({super.key});

  @override
  State<LandLordDashboardBottomNavigationBar> createState() =>
      _LandLordDashboardBottomNavigationBarState();
}

class _LandLordDashboardBottomNavigationBarState
    extends State<LandLordDashboardBottomNavigationBar> {
  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,

      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      fixedColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          key: Key("Dashboard"),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'messages',
          key: Key("messages"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          key: Key("Settings"),
        ),
      ],
    );
  }
}
