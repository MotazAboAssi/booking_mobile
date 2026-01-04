import 'dart:developer';

import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/get_all_rate_your_stay/get_all_rate_your_stay_cubit.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppartementCard extends StatelessWidget {
  final ApartmentType? apartment;
  const AppartementCard({super.key, this.apartment});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllRateYourStayCubit(),
      child: Builder(
        builder: (context) {
          return Card(
            color: thirdly,
            elevation: 0,

            margin: EdgeInsets.symmetric(horizontal: 2),
            child: LayoutBuilder(
              builder: (context, card) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        try {
                          final ApartmentType house = await HttpRequest()
                              .getApartmentByIDForTenant(
                                apartment!.idApartment,
                              );
                          Navigator.pushNamed(
                            context,
                            appartementDetailsViewForTenant,
                            arguments: {"apartment": house},
                          );
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: card.maxHeight * 0.6,
                            decoration: BoxDecoration(
                              image: apartment != null
                                  ? DecorationImage(
                                      fit: BoxFit.fill,
                                      image: apartment!.images!.isEmpty
                                          ? AssetImage(anonymousManAvatar)
                                          : fetchImageFromDB(
                                              apartment!.images![0].image,
                                            ),
                                    )
                                  : null,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          Container(
                            // color: Th,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              spacing: 5,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LayoutBuilder(
                                      builder:
                                          (
                                            BuildContext context,
                                            BoxConstraints constraints,
                                          ) {
                                            return SizedBox(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                        0.5,
                                                    child: Text(
                                                      "${apartment?.description}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: rem(1),
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${apartment?.rating}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                    ),
                                    Text(
                                      "${apartment?.city}, ${apartment?.town}",
                                      style: TextStyle(
                                        fontSize: rem(1),
                                        color: secondary,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: rem(1),
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.square, color: secondary),
                                        Text(
                                          "${apartment?.rooms} rooms",
                                          style: TextStyle(color: secondary),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.square_foot_sharp,
                                          color: secondary,
                                        ),
                                        Text(
                                          "${apartment?.space} m\u00B2",
                                          style: TextStyle(color: secondary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$${apartment?.priceForMonth}",
                                      style: TextStyle(
                                        fontSize: rem(1.5),
                                        fontWeight: FontWeight.bold,
                                        color: fourthly,
                                      ),
                                    ),
                                    Text(" / month"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
