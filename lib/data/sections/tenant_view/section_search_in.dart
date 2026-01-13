import 'package:booking/data/models/tenant_view/city_card.dart';
import 'package:booking/helper/constant/cities_with_towns.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
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
              TenantKeys.tenantHomeSectionSearchIn.tr(),
              style: TextStyle(fontSize: rem(2), fontWeight: FontWeight.bold),
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: governorates.length,
              itemBuilder: (context, index) {
                return CityCard(indexCity: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
