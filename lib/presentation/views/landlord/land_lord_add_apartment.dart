import 'package:flutter/material.dart';
import 'package:booking/presentation/widgets/Add_Apartment/app_bar_add_apartment.dart';
import 'package:booking/presentation/widgets/Add_Apartment/body_add_apartment.dart';

class LandLordAddApartment extends StatelessWidget {
  const LandLordAddApartment({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
      
      },
      child: Scaffold(
        appBar: addApartmentAppBar(context),
        body: AddApartmentBody(),
      ),
    );
  }
}
