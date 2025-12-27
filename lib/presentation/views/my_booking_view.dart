import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:booking/presentation/widgets/my_Booking/body_my_booking.dart';

class MyBookingView extends StatefulWidget {
  const MyBookingView({super.key});

  @override
  State<MyBookingView> createState() => _LandLordDashboardState();
}

class _LandLordDashboardState extends State<MyBookingView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: const TabBar(
            labelStyle: TextStyle(fontSize: 16),
            labelColor: Color.fromARGB(255, 0, 0, 0),
            unselectedLabelColor: Color.fromARGB(179, 124, 124, 124),
            indicatorColor: Color.fromARGB(255, 12, 75, 194),
            tabs: [
              Tab(text: 'Current'),
              Tab(text: 'Past'),
              Tab(text: 'Canceled'),
            ],
          ),
          bottomNavigationBar: CustomeBottomNavigationBar(index: 2),
          body: Padding(
            padding: EdgeInsets.only(top: rem(1)),
            child: const TabBarView(
              children: [BodyMyBooking(), BodyMyBooking(), BodyMyBooking()],
            ),
          ),
        ),
      ),
    );
  }
}
