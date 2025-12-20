import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class SectionRequestToBookAndPrice extends StatelessWidget {
  final ApartmentTypeForTenant apartment;

  const SectionRequestToBookAndPrice({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: thirdly,
        boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: 5)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "${apartment.priceForMonth}\$",
                style: TextStyle(
                  fontSize: rem(1.5),
                  fontWeight: FontWeight.bold,
                  color: fourthly,
                ),
              ),
              Text(" /month"),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
              backgroundColor: fourthly,
            ),
            onPressed: () {
              Navigator.pushNamed(context, mybooking);
            },
            child: Text("Request to Book", style: TextStyle(color: thirdly)),
          ),
        ],
      ),
    );
  }
}
