import 'package:booking/helper/constant/amentions.dart';
import 'package:booking/helper/constant/cities.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/add_apartment_view/add_apartment_cubit.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicDatails extends StatefulWidget {
  const BasicDatails({super.key});

  @override
  State<BasicDatails> createState() => _BasicDatailsState();
}

class _BasicDatailsState extends State<BasicDatails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  /// قائمة الميزات
  // List<String> amenities = [
  //   "Wifi",
  //   "Parking",
  //   "Air Conditioner",
  //   "Heater",
  //   "Balcony",
  //   "Elevator",
  // ];

  /// الميزات المختارة
  List<int> selectedAmenities = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  /// COUNTRY
                  Row(
                    children: [
                      Text("Country", style: TextStyle(color: secondary)),
                    ],
                  ),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Country is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "eg. USA",
                      hintStyle: TextStyle(fontSize: rem(1)),
                    ),
                    items: cities
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        cityController.text = value;
                      }
                    },
                  ),
                  SizedBox(height: 10),

                  /// CITY
                  Row(
                    children: [
                      Text("City", style: TextStyle(color: secondary)),
                    ],
                  ),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "City is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "eg. New York",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    items: cities
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          cityController.text = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),

                  /// ROOMS NUMBER
                  Row(
                    children: [
                      Text("Rooms number", style: TextStyle(color: secondary)),
                    ],
                  ),
                  TextFormField(
                    controller: roomsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "eg. 3",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return "Rooms number is required";
                      if (int.tryParse(v) == null) {
                        return "Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  /// ROOMS NUMBER
                  Row(
                    children: [
                      Text("Space m\u00B2", style: TextStyle(color: secondary)),
                    ],
                  ),
                  TextFormField(
                    controller: spaceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "eg. 120",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return "Space number is required";
                      if (int.tryParse(v) == null) {
                        return "Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  /// PRICE
                  Row(
                    children: [
                      Text(
                        "Price per month in Lsy",
                        style: TextStyle(color: secondary),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "eg. 1000000",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return "Price is required";
                      if (int.tryParse(v) == null) {
                        return "Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  /// DESCRIPTION
                  Row(
                    children: [
                      Text("Description", style: TextStyle(color: secondary)),
                    ],
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Describe your apartment",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Description is required" : null,
                  ),
                  SizedBox(height: 10),

                  // Row(
                  //   children: [
                  //     Text("Amenities", style: TextStyle(color: secondary)),
                  //   ],
                  // ),
                  // <<<<<<< HEAD

                  //                   // AspectRatio(
                  //                   //   aspectRatio: 1,
                  //                   //   child: ListView(
                  //                   //     children: amentions.map((item) {
                  //                   //       return CheckboxListTile(
                  //                   //         value: selectedAmenities.contains(item.id),
                  //                   //         title: AmentionCard(
                  //                   //           icon: item.icon,
                  //                   //           title: item.title,
                  //                   //           fontSize: 1,
                  //                   //           iconsSize: 2,
                  //                   //         ),
                  //                   //         onChanged: (bool? selected) {
                  //                   //           setState(() {
                  //                   //             if (selected == true) {
                  //                   //               selectedAmenities.add(item.id);
                  //                   //             } else {
                  //                   //               selectedAmenities.remove(item.id);
                  //                   //             }
                  //                   //           });
                  //                   //         },
                  //                   //       );
                  //                   //     }).toList(),
                  //                   //   ),
                  //                   // ),
                  //                   Row(
                  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text(
                  //                         "Amenities",
                  //                         style: TextStyle(
                  //                           color: secondary,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ],
                  Row(
                    children: [
                      Text(
                        "Amenities",
                        style: TextStyle(
                          color: secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.all(5),
                    height: rem(20),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,

                      itemCount: amentions.length,
                      itemBuilder: (context, index) {
                        final item = amentions[index];
                        final bool isSelected = selectedAmenities.contains(
                          item.id,
                        );

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
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey,
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
                ],
              ),
            ),
          ),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    print("Saved as draft");
                    print(selectedAmenities);
                  },
                  child: Text("Save As Draft"),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ApartmentType apartment =
                          BlocProvider.of<AddApartmentCubit>(
                            context,
                          ).state.apartment;
                      try {
                        apartment.features = selectedAmenities;
                        apartment.city = countryController.text;
                        apartment.town = cityController.text;
                        apartment.description = descriptionController.text;
                        apartment.priceForMonth = int.parse(
                          priceController.text,
                        );
                        apartment.rooms = int.parse(roomsController.text);
                        apartment.space = int.parse(spaceController.text);
                        
                      } catch (e) {
                        printRed(e.toString());
                      }
                      apartment = ApartmentType.empty();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 143, 36),
                  ),
                  child: Text(
                    "Publish",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: rem(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
