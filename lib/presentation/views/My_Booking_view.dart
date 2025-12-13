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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Booking"),
          centerTitle: true,
          leading: Icon(Icons.arrow_back),
          bottom: const TabBar(
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
        ),
        body: const TabBarView(
          children: [BodyMyBooking(), BodyMyBooking(), BodyMyBooking()],
        ),
      ),
    );
  }
}
