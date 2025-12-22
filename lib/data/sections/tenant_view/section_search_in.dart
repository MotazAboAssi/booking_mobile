import 'package:booking/data/models/tenant_view/city_card.dart';
import 'package:booking/helper/constant/cities.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class SectionSearchIn extends StatelessWidget {
  const SectionSearchIn({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              "Search in",
              style: TextStyle(fontSize: rem(2), fontWeight: FontWeight.bold),
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return CityCard(city: cities[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
