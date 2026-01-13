import 'package:booking/data/models/MyBooking/appartment_booking.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter/material.dart';

class BodyMyBooking extends StatelessWidget {
  final List<BookingApartmentType> apartments;
  const BodyMyBooking({super.key, required this.apartments});

  @override
  Widget build(BuildContext context) {
    return apartments.isEmpty
        ? Center(
            child: Text(
              TenantKeys.bookingEmptyMessage,
              style: TextStyle(fontSize: rem(1), fontWeight: FontWeight.bold),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: AspectRatio(
              aspectRatio: 7 / 6,
              child: ListView.builder(
                itemCount: apartments.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return AspectRatio(
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
