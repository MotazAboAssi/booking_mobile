import 'package:booking/data/models/tenant_view/apartement_card.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DisplayFilterView extends StatelessWidget {
  const DisplayFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ApartmentType> apartments =
        (ModalRoute.of(context)?.settings.arguments as Map)['apartments'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TenantKeys.filterTitle.tr(),
          style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
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
