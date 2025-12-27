import 'package:booking/helper/constant/my_booking_keys.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/image_network.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Appartmentbooking extends StatelessWidget {
  final BookingApartmentType? apartment;
  const Appartmentbooking({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: thirdly,
      elevation: 0,

      margin: EdgeInsets.symmetric(horizontal: 2),
      child: LayoutBuilder(
        builder: (context, card) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: card.maxHeight * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: networkImage,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                // color: Th,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${apartment?.status.name}',
                              style: TextStyle(
                                color: context.select<Null, Color?>((_) {
                                  if (apartment?.status.name == pendingKey) {
                                    return Colors.grey;
                                  } else if (apartment?.status.name ==
                                      confirmedKey) {
                                    return Colors.green;
                                  } else {
                                    return Colors.red;
                                  }
                                }),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Modern Apartement in Abdoun",
                              style: TextStyle(
                                fontSize: rem(1),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            Text(
                              "Abdoun, Amman",
                              style: TextStyle(
                                fontSize: rem(1),
                                color: secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(Icons.date_range, color: Colors.grey),
                        Text(
                          "${apartment?.startDate.toIso8601String().split("T")[0]} / ${apartment?.endDate.toIso8601String().split("T")[0]}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    
                    
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                70,
                                134,
                                231,
                              ), // لون الخلفية
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // بدون انحناءات
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ), // حجم اللزر
                            ),
                            onPressed: () => {
                              Navigator.pushNamed(
                                context,
                                appartementDetailsView,
                              ),
                            },
                            child: Text(
                              "view details",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                170,
                                172,
                                170,
                              ), // لون الخلفية
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // بدون انحناءات
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ), // حجم الزر
                            ),
                            onPressed: () => {},
                            child: Text(
                              "Contact owner",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
