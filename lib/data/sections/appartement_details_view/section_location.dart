import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SectionLocation extends StatelessWidget {
  final ApartmentType apartment;

  const SectionLocation({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            TenantKeys.detailLocationTitle.tr(),
            style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
          ),
        ),
        AspectRatio(
          aspectRatio: 6 / 5,
          child: Container(
            decoration: BoxDecoration(
              color: context.appTheme.secondary.withAlpha(127),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  TenantKeys.detailLocationNotAvailable.tr(),
                  style: TextStyle(fontSize: rem(2)),
                ),
                Text("😢", style: TextStyle(fontSize: rem(2))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
