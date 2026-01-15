import 'package:booking/data/sections/tenant_view/section_search_and_filter.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/convert_string_to_list_of_string.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cities = convertStringToListOfString(
      TenantKeys.tenantHomeSectionSearchInCities.tr().toString(),
    );
    final indexCity =
        (ModalRoute.of(context)?.settings.arguments as Map)['indexCity'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${TenantKeys.filterTitle.tr()} ${cities[indexCity]} ',
          style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: BodyFilterView()),
    );
  }
}

String normalizeKey(String value) {
  return value
      .toLowerCase()
      .replaceAll('&', 'and')
      .replaceAll(RegExp(r'[\s\-]+'), '_');
}
