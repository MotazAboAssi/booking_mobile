import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/methods/to_capitalize.dart';
import 'package:booking/presentation/views/tenant/filter_view.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DispalyResaultCategory extends StatelessWidget {
  const DispalyResaultCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ApartmentType> apartments =
        (ModalRoute.of(context)?.settings.arguments as Map)['apartments'];
    return Scaffold(
      appBar: AppBar(),
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
                          onTap: () async {
                            final ApartmentType house = await HttpRequest()
                                .getApartmentByIDForLandlord(
                                  apartments[index].idApartment,
                                );
                            await Navigator.pushNamed(
                              context,
                              appartementDetailsViewForLandlord,
                              arguments: {'apartment': house},
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
                                    color: context.appTheme.primarye.withAlpha(
                                      127,
                                    ),
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
                                          "${'cities.${normalizeKey(apartments[index].town ?? "")}'.tr()} - ${'governorates.${normalizeKey(apartments[index].city ?? "")}'.tr()}",
                                        ),
                                        style: TextStyle(
                                          fontSize: rem(1.5),
                                          fontWeight: FontWeight.bold,
                                          color: context.appTheme.thirdly,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${apartments[index].rating}',
                                            style: TextStyle(
                                              color: context.appTheme.thirdly,
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
                  color: context.appTheme.secondary,
                  borderRadius: BorderRadius.circular(rem(1.4)),
                ),
                child: Center(
                  child: Text(
                    "⚠️ Not Found Apartment",
                    style: TextStyle(
                      fontSize: rem(1.5),
                      fontWeight: FontWeight.bold,
                      color: context.appTheme.thirdly,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
