import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class SectionTitleAndPosition extends StatelessWidget {
  final ApartmentType apartment;
  const SectionTitleAndPosition({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Modern 2-Bedroom Loft in Downtown",
        //   style: TextStyle(fontSize: rem(2), fontWeight: FontWeight.w900),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "${apartment.city}, ${apartment.town}",
            style: TextStyle(color: secondary, fontSize: rem(1.5)),
          ),
        ),
      ],
    );
  }
}
