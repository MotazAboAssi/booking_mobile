import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/views/tenant/filter_view.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SectionTitleAndPosition extends StatelessWidget {
  final ApartmentType apartment;
  const SectionTitleAndPosition({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "${'cities.${normalizeKey(apartment.town)}'.tr()}, "
            "${'governorates.${normalizeKey(apartment.city)}'.tr()}",
            style: TextStyle(
              color: context.appTheme.secondary,
              fontSize: rem(1.5),
            ),
          ),
        ),
      ],
    );
  }
}
