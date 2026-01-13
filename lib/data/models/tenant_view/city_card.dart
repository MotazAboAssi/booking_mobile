import 'package:booking/helper/constant/cities_with_towns.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/convert_string_to_list_of_string.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final int indexCity;
  const CityCard({super.key, required this.indexCity});

  @override
  Widget build(BuildContext context) {
    final List<String> cities = convertStringToListOfString(
      TenantKeys.tenantHomeSectionSearchInCities.tr().toString(),
    );
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(
          context,
          filterView,
          arguments: {"indexCity": indexCity},
        );
      },
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(2),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/freedom.jpg"),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withAlpha(127),
                ),
              ),
              Center(
                child: Text(
                  cities[indexCity],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: rem(1.1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
