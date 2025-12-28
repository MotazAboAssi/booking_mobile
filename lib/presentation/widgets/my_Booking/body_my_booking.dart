import 'package:booking/data/models/MyBooking/appartment_booking.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter/material.dart';

class BodyMyBooking extends StatelessWidget {
  final List<BookingApartmentType> apartments;
  const BodyMyBooking({super.key, required this.apartments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: AspectRatio(
        aspectRatio: 7 / 6,
        child: ListView.builder(
          itemCount: apartments.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return apartments.isEmpty
                ? null
                : AspectRatio(
                    aspectRatio: 1,
                    child: Appartmentbooking(apartment: apartments[index]),
                  );
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
