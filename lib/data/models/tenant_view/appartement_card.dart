import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class AppartementCard extends StatelessWidget {
  final bool isFavorite;
  final ApartmentType? apartment;
  const AppartementCard({super.key, required this.isFavorite, this.apartment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: thirdly,
      elevation: 0,

      margin: EdgeInsets.symmetric(horizontal: 2),
      child: LayoutBuilder(
        builder: (context, card) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                appartementDetailsView,
                arguments: {"apartment": apartment},
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: card.maxHeight * 0.6,
                      decoration: BoxDecoration(
                        image: apartment != null
                            ? DecorationImage(
                                fit: BoxFit.fill,
                                image: fetchImageFromDB(
                                  apartment!.images[0].image,
                                ),
                              )
                            : null,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),

                    Positioned(
                      right: 10,
                      top: 10,
                      child: InkWell(
                        child: CircleAvatar(
                          backgroundColor: primary.withAlpha(125),
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              color: isFavorite
                                  ? const Color.fromARGB(255, 255, 17, 0)
                                  : thirdly,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${apartment?.rating}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.star, color: Colors.amber),
                                ],
                              ),
                            ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              Icon(Icons.square_foot_sharp, color: secondary),
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
          );
        },
      ),
    );
  }
}
