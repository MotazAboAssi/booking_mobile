import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/methods/to_capitalize.dart';
import 'package:flutter/material.dart';

class DispalyResaultCategory extends StatelessWidget {
  const DispalyResaultCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final apartments =
        (ModalRoute.of(context)?.settings.arguments as Map)['apartments'];
    return Scaffold(
      body: SafeArea(
        child: apartments.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(rem(1)),
                itemCount: apartments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: rem(1)),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints card) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              appartementDetailsViewForLandlord,
                              arguments: {'apartment': apartments[index]},
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: apartments[index].images!.isEmpty
                                          ? AssetImage(anonymousManAvatar)
                                          : fetchImageFromDB(
                                              apartments[index]
                                                  .images![0]
                                                  .image,
                                            ),
                                    ),
                                    borderRadius: BorderRadius.circular(rem(1)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: primary.withAlpha(127),
                                    borderRadius: BorderRadius.circular(rem(1)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(rem(0.5)),
                                  child: Row(
                                    spacing: rem(0.2),
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        toCapitalize(
                                          '${apartments[index].city} , ${apartments[index].town}',
                                        ),
                                        style: TextStyle(
                                          fontSize: rem(1.5),
                                          fontWeight: FontWeight.bold,
                                          color: thirdly,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${apartments[index].rating}',
                                            style: TextStyle(
                                              color: thirdly,
                                              fontWeight: FontWeight.bold,
                                              fontSize: rem(1.5),
                                            ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: rem(1.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            : Container(
                margin: EdgeInsets.all(rem(0.5)),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(rem(1.4)),
                ),
                child: Center(
                  child: Text(
                    "⚠️ Not Found Apartment",
                    style: TextStyle(
                      fontSize: rem(1.5),
                      fontWeight: FontWeight.bold,
                      color: thirdly,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
