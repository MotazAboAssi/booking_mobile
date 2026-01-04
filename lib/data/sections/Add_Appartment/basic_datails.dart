import 'dart:developer';

import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/amentions.dart';
import 'package:booking/helper/constant/cities.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_states.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicDatails extends StatefulWidget {
  const BasicDatails({super.key});

  @override
  State<BasicDatails> createState() => _BasicDatailsState();
}

class _BasicDatailsState extends State<BasicDatails> {
  // String? selectedCity;
  // String? selectedCountry;

  @override
  void initState() {
    super.initState();
    // selectedCity = cities.first;
    // selectedCountry = cities.first;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  /// الميزات المختارة

  List<int> selectedAmenities = [];
  // List<int> selectedAmenities = apartment?.features ?? [1];
  @override
  Widget build(BuildContext context) {
    ApartmentType? apartment;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      apartment =
          (ModalRoute.of(context)?.settings.arguments as Map)['apartment'];
      selectedAmenities = apartment!.features;
    }

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
                    initialValue: context.select<Null, String?>((value) {
                      if (apartment?.city == null) {
                        return null;
                      } else {
                        return apartment!.city;
                      }
                    }),
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
                        setState(() {
                          countryController.text = value;
                          // value = '';
                        });
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
                  DropdownButtonFormField<String>(
                    initialValue: context.select<Null, String?>((value) {
                      if (apartment?.town == null) {
                        return null;
                      } else {
                        return apartment!.town;
                      }
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "City is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "eg. New York",
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    items: cities
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        // selectedCity = value;
                        cityController.text = value ?? '';
                      });
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
                    initialValue: '${apartment?.rooms ?? ''}',
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
                    onChanged: (value) {
                      roomsController.text = value;
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
                    initialValue: '${apartment?.space ?? ''}',
                    // controller: spaceController,
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
                    onChanged: (value) {
                      spaceController.text = value;
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
                    // controller: priceController,
                    initialValue: '${apartment?.priceForMonth ?? ''}',
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
                    onChanged: (value) {
                      priceController.text = value;
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
                    // controller: descriptionController,
                    initialValue: apartment?.description ?? '',
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Describe your apartment",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Description is required" : null,
                    onChanged: (value) {
                      descriptionController.text = value;
                    },
                  ),
                  SizedBox(height: 10),
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
                          child: InkWell(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: context
                        .select<ApiApartmentCubit, void Function()?>((cubit) {
                          if (cubit.state is ApiApartmentLoading) {
                            return null;
                          }
                          return () async {
                            if (_formKey.currentState!.validate()) {
                              ApartmentType apartment =
                                  BlocProvider.of<ApiApartmentCubit>(
                                    context,
                                  ).state.apartment;
                              try {
                                apartment.features = selectedAmenities;
                                apartment.city = countryController.text;
                                apartment.town = cityController.text;
                                apartment.description =
                                    descriptionController.text;
                                log(roomsController.text);
                                apartment.priceForMonth = int.parse(
                                  priceController.text,
                                );
                                apartment.rooms = int.parse(
                                  roomsController.text,
                                );
                                apartment.space = int.parse(
                                  spaceController.text,
                                );

                                final cubit =
                                    BlocProvider.of<ApiApartmentCubit>(context);
                                cubit.add(apartment);
                              } catch (e) {
                                printRed(e.toString());
                              }
                            }
                          };
                        }),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: fourthly,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(rem(0.5)),
                      ),
                    ),
                    child: BlocConsumer<ApiApartmentCubit, ApiApartmentStates>(
                      builder: (context, state) {
                        if (state is ApiApartmentLoading) {
                          return SizedBox(
                            width: rem(1),
                            height: rem(1),
                            child: CircularProgressIndicator(color: thirdly),
                          );
                        } else if (state is ApiApartmentSuccefulAdd) {
                          return Icon(
                            Icons.check,
                            size: rem(1.5),
                            color: thirdly,
                          );
                        } else {
                          return Text(
                            "Publish",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: rem(1),
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                      listener:
                          (BuildContext context, ApiApartmentStates state) {
                            if (state is ApiApartmentSuccefulAdd) {
                              customSnakBar(
                                context: context,
                                color: Colors.green,
                                message: 'Done, add new apartment',
                              );
                              Future.delayed(Duration(milliseconds: 500));
                              Navigator.pop(context);
                            } else if (state is ApiApartmentFaild) {
                              customSnakBar(
                                context: context,
                                color: Colors.red,
                                message: '${state.message}',
                              );
                            }
                          },
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
