import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

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
  TextEditingController descriptionController = TextEditingController();

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  /// نخزن التواريخ فعليًا بدل النص
  DateTime? fromDate;
  DateTime? toDate;

  /// قائمة الميزات
  List<String> amenities = [
    "Wifi",
    "Parking",
    "Air Conditioner",
    "Heater",
    "Balcony",
    "Elevator",
  ];

  /// الميزات المختارة
  List<String> selectedAmenities = [];

  /// دالة اختيار التاريخ
  Future<void> pickDate(TextEditingController controller, bool isFrom) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      // صيغة صحيحة yyyy-MM-dd
      final y = picked.year.toString();
      final m = picked.month.toString().padLeft(2, '0');
      final d = picked.day.toString().padLeft(2, '0');

      controller.text = "$y-$m-$d";

      setState(() {
        if (isFrom) {
          fromDate = DateTime(picked.year, picked.month, picked.day);
        } else {
          toDate = DateTime(picked.year, picked.month, picked.day);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          Form(
            key: _formKey,
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
                  TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      hintText: "eg. USA",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    validator: (v) => v!.isEmpty ? "Country is required" : null,
                  ),
                  SizedBox(height: 10),

                  /// CITY
                  Row(
                    children: [
                      Text("City", style: TextStyle(color: secondary)),
                    ],
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: "eg. New York",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    validator: (v) => v!.isEmpty ? "City is required" : null,
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

                  /// AMENITIES
                  Row(
                    children: [
                      Text("Amenities", style: TextStyle(color: secondary)),
                    ],
                  ),

                  Column(
                    children: amenities.map((item) {
                      return CheckboxListTile(
                        value: selectedAmenities.contains(item),
                        title: Text(item),
                        onChanged: (bool? selected) {
                          setState(() {
                            if (selected == true) {
                              selectedAmenities.add(item);
                            } else {
                              selectedAmenities.remove(item);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 10),

                  /// DATE FROM
                  Row(
                    children: [
                      Text(
                        "Available From",
                        style: TextStyle(color: secondary),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: fromDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Select start date",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Start date is required" : null,
                    onTap: () => pickDate(fromDateController, true),
                  ),
                  SizedBox(height: 10),

                  /// DATE TO
                  Row(
                    children: [
                      Text("Available To", style: TextStyle(color: secondary)),
                    ],
                  ),
                  TextFormField(
                    controller: toDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Select end date",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return "End date is required";
                      if (fromDate == null) return "Select start date first";
                      if (toDate == null) return "Invalid end date";

                      if (toDate!.isBefore(fromDate!)) {
                        return "End date cannot be before start date";
                      }
                      return null;
                    },
                    onTap: () => pickDate(toDateController, false),
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
                      print("Published successfully");
                      print("Selected: $selectedAmenities");
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
