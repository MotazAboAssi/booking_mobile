import 'package:booking/data/models/MyBooking/AppartmentBooking.dart';
import 'package:flutter/material.dart';

class BodyMyBooking extends StatelessWidget {
  const BodyMyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: AspectRatio(
        aspectRatio: 7 / 6,
        child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return AspectRatio(aspectRatio: 1, child: Appartmentbooking());
          },
        ),
      ),
    );
    // return ListView.builder(
    //   padding: const EdgeInsets.all(16),
    //   itemCount: 10,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.only(bottom: 16),
    //       child: Appartmentbooking(),
    //     );
    //   },
    // );
  }
}
