import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class SectionDescription extends StatelessWidget {
  final ApartmentTypeForTenant apartment;

  const SectionDescription({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "Description",
            style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          apartment.description,
          style: TextStyle(color: secondary, fontSize: rem(1)),
        ),
      ],
    );
  }
}
