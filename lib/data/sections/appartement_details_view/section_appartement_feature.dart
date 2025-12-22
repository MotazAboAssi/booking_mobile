import 'package:booking/helper/constant/theme.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class SectionAppartementFeature extends StatelessWidget {
  final ApartmentType apartment;

  const SectionAppartementFeature({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              spacing: 5,
              children: [
                Icon(Icons.square, color: fourthly),
                Text("${apartment.rooms} rooms"),
              ],
            ),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.square_foot_sharp, color: fourthly),
                Text("${apartment.space} m\u00B2"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
