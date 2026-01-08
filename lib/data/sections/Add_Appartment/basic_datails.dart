import 'dart:developer';

import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/amentions.dart';
import 'package:booking/helper/constant/cities_with_towns.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
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
  String? selectedCountry;
  String? selectedCity;
  List<String> cities = [];

  final _formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ApartmentType? apartmentCopy;

  /// الميزات المختارة

  List<int> selectedAmenities = [];
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      apartmentCopy =
          (ModalRoute.of(context)!.settings.arguments as Map)['apartment'];
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// COUNTRY
                  Row(
                    children: [
                      Text(
                        "Country",
                        style: TextStyle(color: context.appTheme.secondary),
                      ),
                    ],
                  ),
                  apartmentCopy?.city != null
                      ? Text(apartmentCopy!.city)
                      : DropdownButtonFormField(
                          initialValue: selectedCountry,
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

                          items: governorates
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            if (value == null) return;

                            setState(() {
                              selectedCountry = value;
                              countryController.text = value;

                              // update cities list based on country
                              cities = citiesByGovernorate[value]!;

                              // IMPORTANT: reset city
                              selectedCity = null;
                              cityController.clear();
                            });
                          },
                        ),
                  SizedBox(height: 10),

                  /// CITY
                  Row(
                    children: [
                      Text(
                        "City",
                        style: TextStyle(color: context.appTheme.secondary),
                      ),
                    ],
                  ),
                  apartmentCopy?.town != null
                      ? Text(apartmentCopy!.town)
                      : DropdownButtonFormField<String>(
                          initialValue: selectedCity,
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
                              selectedCity = value;
                              cityController.text = value ?? '';
                            });
                          },
                        ),
                  SizedBox(height: 10),

                  /// ROOMS NUMBER
                  Row(
                    children: [
                      Text(
                        "Rooms number",
                        style: TextStyle(color: context.appTheme.secondary),
                      ),
                    ],
                  ),
                  InputRoomNumver(
                    apartmentCopy: apartmentCopy,
                    roomsController: roomsController,
                  ),
                  SizedBox(height: 10),

                  /// ROOMS NUMBER
                  Row(
                    children: [
                      Text(
                        "Space m\u00B2",
                        style: TextStyle(color: context.appTheme.secondary),
                      ),
                    ],
                  ),
                  InputSpace(
                    apartmentCopy: apartmentCopy,
                    spaceController: spaceController,
                  ),
                  SizedBox(height: 10),

                  /// PRICE
                  Row(
                    children: [
                      Text(
                        "Price per month in Lsy",
                        style: TextStyle(color: context.appTheme.secondary),
                      ),
                    ],
                  ),
                  InputPriceForMonth(
                    apartmentCopy: apartmentCopy,
                    priceController: priceController,
                  ),
                  SizedBox(height: 10),

                  /// DESCRIPTION
                  Row(
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(color: context.appTheme.secondary),
                      ),
                    ],
                  ),
                  InputDescription(
                    apartmentCopy: apartmentCopy,
                    descriptionController: descriptionController,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Amenities",
                        style: TextStyle(
                          color: context.appTheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.all(5),
                    height: rem(20),
                    child: GridView.builder(
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
                              printRed('Selected : $isSelected');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? context.appTheme.fourthly.withAlpha(50)
                                    : context.appTheme.secondary.withAlpha(13),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected
                                      ? context.appTheme.fourthly
                                      : context.appTheme.secondary.withAlpha(
                                          51,
                                        ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item.icon,
                                    color: isSelected
                                        ? context.appTheme.fourthly
                                        : context.appTheme.secondary,
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
                                            ? context.appTheme.fourthly
                                            : context.appTheme.primarye,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: context.appTheme.fourthly,
                                      size: 20,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        crossAxisSpacing: rem(1),
                        mainAxisSpacing: rem(0.5),
                      ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appTheme.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(rem(0.5)),
                      ),
                    ),
                    onPressed: () {
                      apartmentCopy = null;
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Discard",
                      style: TextStyle(
                        color: context.appTheme.thirdly,
                        fontSize: rem(1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
                              try {
                                ApartmentType? apartmenFromCubit =
                                    BlocProvider.of<ApiApartmentCubit>(
                                      context,
                                    ).state.apartment;

                                apartmenFromCubit.features = selectedAmenities;
                                apartmenFromCubit.city =
                                    countryController.text.isEmpty
                                    ? apartmentCopy!.city
                                    : countryController.text;

                                apartmenFromCubit.town =
                                    cityController.text.isEmpty
                                    ? apartmentCopy!.town
                                    : cityController.text;

                                apartmenFromCubit.description =
                                    descriptionController.text.isEmpty
                                    ? apartmentCopy!.description
                                    : descriptionController.text;

                                apartmenFromCubit.priceForMonth =
                                    priceController.text.isEmpty
                                    ? apartmentCopy!.priceForMonth
                                    : int.parse(priceController.text);

                                log(roomsController.text);
                                apartmenFromCubit.rooms =
                                    roomsController.text.isEmpty
                                    ? apartmentCopy!.rooms
                                    : int.parse(roomsController.text);

                                apartmenFromCubit.space =
                                    spaceController.text.isEmpty
                                    ? apartmentCopy!.space
                                    : int.parse(spaceController.text);

                                if (apartmentCopy != null) {
                                  apartmenFromCubit.idApartment =
                                      apartmentCopy!.idApartment;
                                }
                                final cubit =
                                    BlocProvider.of<ApiApartmentCubit>(context);

                                // apartmentCopy == null
                                //     ? print('object')
                                //     :
                                apartmentCopy == null
                                    ? cubit.add(apartmenFromCubit)
                                    : cubit.update(
                                        apartmenFromCubit,
                                        cubit.state.deleteImage,
                                      );
                              } catch (e) {
                                printRed(e.toString());
                              }
                            }
                          };
                        }),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appTheme.fourthly,
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
                            child: CircularProgressIndicator(
                              color: context.appTheme.thirdly,
                            ),
                          );
                        } else if (state is ApiApartmentSuccefulAdd) {
                          return Icon(
                            Icons.check,
                            size: rem(1.5),
                            color: context.appTheme.thirdly,
                          );
                        } else {
                          return Text(
                            // apartmentCopy != null ? "Save" :
                            "Publish",
                            style: TextStyle(
                              color: context.appTheme.thirdly,
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
                                color: context.appTheme.success,
                                message: 'Done, add new apartment',
                              );
                              Future.delayed(Duration(milliseconds: 500));
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                landlordDashBoard,
                                (Route<dynamic> route) => false,
                              );
                            } else if (state is ApiApartmentFaild) {
                              customSnakBar(
                                context: context,
                                color: context.appTheme.error,
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

class InputDescription extends StatelessWidget {
  const InputDescription({
    super.key,
    required this.apartmentCopy,
    required this.descriptionController,
  });

  final ApartmentType? apartmentCopy;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: descriptionController,
      initialValue: apartmentCopy?.description ?? '',
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Describe your apartment",
        border: OutlineInputBorder(),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) {
          return "Description is required";
        } else if (v.length < 10) {
          return 'Description is bigger than 7 character';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        descriptionController.text = value;
      },
      maxLength: 70,
      buildCounter:
          (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) {
            if (isFocused) {
              if (currentLength < 10) {
                return Text(
                  '$currentLength > 10',
                  style: TextStyle(color: context.appTheme.error),
                );
              } else if (currentLength == maxLength) {
                return Text(
                  '$currentLength = $maxLength',
                  style: TextStyle(color: context.appTheme.error),
                );
              } else {
                return Text('$currentLength < $maxLength');
              }
            }
            return null;
          },
    );
  }
}

class InputPriceForMonth extends StatelessWidget {
  const InputPriceForMonth({
    super.key,
    required this.apartmentCopy,
    required this.priceController,
  });

  final ApartmentType? apartmentCopy;
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: priceController,
      initialValue: apartmentCopy?.priceForMonth == null
          ? null
          : '${apartmentCopy!.priceForMonth}',
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
    );
  }
}

class InputSpace extends StatelessWidget {
  const InputSpace({
    super.key,
    required this.apartmentCopy,
    required this.spaceController,
  });

  final ApartmentType? apartmentCopy;
  final TextEditingController spaceController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: apartmentCopy?.space == null
          ? null
          : '${apartmentCopy!.space}',
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
    );
  }
}

class InputRoomNumver extends StatelessWidget {
  const InputRoomNumver({
    super.key,
    required this.apartmentCopy,
    required this.roomsController,
  });

  final ApartmentType? apartmentCopy;
  final TextEditingController roomsController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: apartmentCopy?.rooms == null
          ? null
          : '${apartmentCopy?.rooms}',
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
    );
  }
}
