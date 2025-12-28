import 'package:booking/data/models/tenant_view/appartement_card.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/filter_type.dart';
import 'package:flutter/material.dart';

class DisplayFilterView extends StatelessWidget {
  const DisplayFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ApartmentType> apartments =
        (ModalRoute.of(context)?.settings.arguments as Map)['apartments'];

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: apartments.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: AppartementCard(apartment: apartments[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ListView.builder(
//               itemCount: apartments.length,
//               itemBuilder: (context, index) {
//                 return AppartementCard(apartment: apartments[index]);
//               },
//             )
