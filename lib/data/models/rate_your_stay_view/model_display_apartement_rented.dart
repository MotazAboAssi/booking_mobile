import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter/material.dart';

class ModelDisplayApartementRented extends StatelessWidget {
  const ModelDisplayApartementRented({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingApartmentType apartment =
        (ModalRoute.of(context)?.settings.arguments as Map)['house'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: thirdly,
      ),
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 4, vertical: 4),
        title: Text(
          "${apartment.apartment.city} / ${apartment.apartment.town}",
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Stay: ${apartment.startDate.toIso8601String().split('T')[0]} - ${apartment.endDate.toIso8601String().split('T')[0]}",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        trailing: AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: fetchImageFromDB(
                  apartment.apartment.images?[0].image ?? "",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
