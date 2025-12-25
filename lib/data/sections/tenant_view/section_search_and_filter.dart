import 'package:booking/helper/constant/theme.dart';
import 'package:flutter/material.dart';

class SectionSearchAndFilter extends StatelessWidget {
  const SectionSearchAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          trailing: Container(
            decoration: BoxDecoration(
              color: fourthly,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.filter_alt_rounded, color: thirdly, size: 30),
          ),
          title: TextFormField(
            decoration: InputDecoration(
              hintText: "Search by ..",
              prefixIcon: InkWell(child: Icon(Icons.search)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
