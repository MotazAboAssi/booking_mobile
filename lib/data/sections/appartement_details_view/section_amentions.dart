import 'package:booking/data/models/appartement_details_view/amention_display.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class SectionAmentions extends StatelessWidget {
  final ApartmentType apartment;

  const SectionAmentions({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "Amention",
            style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
          ),
        ),
        AspectRatio(
          aspectRatio: 20 / 9,
          child: GridView(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 25 / 9,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            children: amentionDisplay(context, apartment.features),
          ),
        ),
      ],
    );
  }
}
