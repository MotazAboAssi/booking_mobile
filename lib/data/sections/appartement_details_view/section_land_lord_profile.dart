import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/image_network.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class SectionLandLordProfile extends StatelessWidget {
  final ApartmentType apartment;

  const SectionLandLordProfile({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  CircleAvatar(backgroundImage: networkImage, radius: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Owner", style: TextStyle(color: secondary)),
                      Text(
                        "Motaz Abo Assi",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    "4.9",
                    style: TextStyle(
                      fontSize: rem(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(" (124)"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
