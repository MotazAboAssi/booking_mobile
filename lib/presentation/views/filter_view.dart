import 'package:booking/data/sections/tenant_view/section_search_and_filter.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter",
          style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: BodyFilterView()),
    );
  }
}
