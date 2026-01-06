import 'package:booking/data/sections/Add_Appartment/basic_datails.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:booking/data/sections/Add_Appartment/section_select_photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddApartmentBody extends StatelessWidget {
  const AddApartmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Photos",
              style: TextStyle(
                fontSize: rem(1.4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SectionSelectPhoto(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Basic Details",
              style: TextStyle(
                fontSize: rem(1.4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BasicDatails(),
        ],
      ),
    );
  }
}
