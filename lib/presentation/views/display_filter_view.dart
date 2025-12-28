import 'package:booking/data/models/tenant_view/appartement_card.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/filter_type.dart';
import 'package:flutter/material.dart';

class DisplayFilterView extends StatelessWidget {
  // final List<ApartmentType> apartments;
  const DisplayFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ApartmentType> apartments = (ModalRoute.of(context)?.settings.arguments as Map)['apartments'];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(rem(0.5)),
          child: ListView.builder(
            itemCount: apartments.length,
            itemBuilder: (context, index) {
              return AppartementCard(apartment: apartments[index]);
            },
          ),
        ),
      ),
    );
  }
}
