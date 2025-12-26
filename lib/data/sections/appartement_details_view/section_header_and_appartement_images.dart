import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/back_to.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class SectionHeaderAndAppartementImages extends StatelessWidget {
  final ApartmentType? apartment;

  const SectionHeaderAndAppartementImages({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);
    printGreen(apartment!.images![0].image.toString());
    return Stack(
      children: [
        Container(
          decoration: apartment != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image: fetchImageFromDB(apartment!.images![0].image),
                  ),
                )
              : null,
        ),
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: primary.withAlpha(127),
              child: IconButton(
                onPressed: () {
                  isFavorite.value = !isFavorite.value;
                },
                icon: ValueListenableBuilder(
                  valueListenable: isFavorite,
                  builder: (context, value, child) {
                    return Icon(
                      Icons.favorite,
                      color: isFavorite.value ? Colors.red : thirdly,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: primary.withAlpha(127),
            child: IconButton(
              onPressed: () {
                backTo(context);
              },
              icon: Icon(Icons.arrow_back, color: thirdly),
            ),
          ),
        ),
      ],
    );
  }
}
