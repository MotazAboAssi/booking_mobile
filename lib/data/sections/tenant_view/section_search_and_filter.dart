import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/constant/amentions.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';
import 'package:booking/helper/constant/cities.dart';

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
            child: IconButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStateProperty.all(
                  thirdly.withOpacity(0.1),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return const FilterBottomSheet();
                  },
                );
              },

              icon: Icon(Icons.filter_alt_rounded, color: thirdly, size: 25),
            ),
          ),
          title: TextFormField(
            decoration: InputDecoration(
              hintText: "Search by Owner name",
              prefixIcon: GestureDetector(child: Icon(Icons.search)),
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

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues priceRange = const RangeValues(0, 10000);
  RangeValues roomsRange = const RangeValues(1, 12);
  RangeValues areaRange = const RangeValues(40, 500);
  String? selectedCity;

  bool hasWifi = false;
  bool hasParking = false;
  bool hasElevator = false;

  List<int> selectedAmenities = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filter",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const Text("City", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCity,
              hint: const Text("Select city"),
              items: cities
                  .map(
                    (city) => DropdownMenuItem(value: city, child: Text(city)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
              decoration: InputDecoration(
                focusColor: Colors.blue,
                suffixIconColor: Colors.blue,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: rem(6),
                  child: Text(
                    "السعر الشهري",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: RangeSlider(
                    min: 0,
                    max: 10000,
                    divisions: 80,
                    values: priceRange,
                    activeColor: Colors.blue,
                    labels: RangeLabels(
                      "\$${priceRange.start.round()}",
                      "\$${priceRange.end.round()}",
                    ),
                    onChanged: (value) {
                      setState(() {
                        priceRange = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: rem(6),
                  child: Text(
                    " مساحة المنزل",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: RangeSlider(
                    min: 40,
                    max: 500,
                    divisions: 25,
                    values: areaRange,
                    activeColor: Colors.blue,
                    labels: RangeLabels(
                      "${areaRange.start.round()}m",
                      "${areaRange.end.round()}m",
                    ),
                    onChanged: (value) {
                      setState(() {
                        areaRange = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: rem(6),
                  child: Text(
                    "عدد الغرف",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: RangeSlider(
                    min: 1,
                    max: 12,
                    divisions: 12,
                    values: roomsRange,
                    activeColor: Colors.blue,
                    labels: RangeLabels(
                      "${roomsRange.start.round()}",
                      "${roomsRange.end.round()}",
                    ),
                    onChanged: (value) {
                      setState(() {
                        roomsRange = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Features",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            Container(
              padding: EdgeInsets.all(5),
              height: rem(20),
              child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,

                itemCount: amentions.length,
                itemBuilder: (context, index) {
                  final item = amentions[index];
                  final bool isSelected = selectedAmenities.contains(item.id);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedAmenities.remove(item.id);
                          } else {
                            selectedAmenities.add(item.id);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? fourthly.withAlpha(50)
                              : Colors.grey.withAlpha(13),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.withAlpha(51),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color: isSelected ? Colors.blue : Colors.grey,
                              size: 24,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.black87,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  print(priceRange);
                },

                child: Text(
                  "Apply Filter",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
