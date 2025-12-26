import 'dart:developer';

import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/toggle_favorite_apartment_button/toggle_favorite_apartment_button_cubit.dart';
import 'package:booking/presentation/cubit/toggle_favorite_apartment_button/toggle_favorite_apartment_button_states.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppartementCard extends StatelessWidget {
  final ApartmentType? apartment;
  const AppartementCard({super.key, this.apartment});

  @override
  Widget build(BuildContext context) {
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
                    Navigator.pushNamed(
                      context,
                      appartementDetailsView,
                      arguments: {"apartment": apartment},
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
                                image: fetchImageFromDB(
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: constraints.maxWidth * 0.5,
                                              child: Text(
                                                "${apartment?.description}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: rem(1),
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${apartment?.rating}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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

              Positioned(
                right: 5,
                top: 5,
                child: BlocProvider(
                  create: (BuildContext context) =>
                      ToggleFavoriteApartmentButtonCubit(),
                  child: FavoriteApartmentButton(apartment: apartment),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FavoriteApartmentButton extends StatelessWidget {
  const FavoriteApartmentButton({super.key, this.apartment});
  final ApartmentType? apartment;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      ToggleFavoriteApartmentButtonCubit,
      ToggleFavoriteApartmentButtonStates
    >(
      builder: (BuildContext context, state) {
        if (state is ToggleFavoriteApartmentButtonLoading) {
          return CircleAvatar(
            backgroundColor: primary.withAlpha(125),
            child: Center(
              child: SizedBox(
                width: rem(1),
                height: rem(1),
                child: CircularProgressIndicator(color: thirdly),
              ),
            ),
          );
        }
        return InkWell(
          onTap: () async {
            final ToggleFavoriteApartmentButtonCubit cubit = context
                .read<ToggleFavoriteApartmentButtonCubit>();
            await cubit.toggle(apartment!.idApartment);
          },
          child: CircleAvatar(
            backgroundColor: primary.withAlpha(125),
            child: Center(
              child: Icon(
                Icons.favorite,
                color: state.isFavorite
                    ? const Color.fromARGB(255, 255, 17, 0)
                    : thirdly,
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {
        if (state is ToggleFavoriteApartmentButtonFaild) {
          customSnakBar(
            margin: EdgeInsets.only(bottom: rem(4)),
            context: context,
            state: state,
            color: Colors.red,
            message: state.message!,
          );
        }
      },
    );
  }
}
