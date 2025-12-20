import 'package:booking/data/sections/appartement_details_view/section_amentions.dart';
import 'package:booking/data/sections/appartement_details_view/section_appartement_feature.dart';
import 'package:booking/data/sections/appartement_details_view/section_description.dart';
import 'package:booking/data/sections/appartement_details_view/section_header_and_appartement_images.dart';
import 'package:booking/data/sections/appartement_details_view/section_land_lord_profile.dart';
import 'package:booking/data/sections/appartement_details_view/section_location.dart';
import 'package:booking/data/sections/appartement_details_view/section_request_to_book_and_price.dart';
import 'package:booking/data/sections/appartement_details_view/section_title_and_position.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

class AppartementDetailsView extends StatelessWidget {
  const AppartementDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ApartmentTypeForTenant apartment =
        (ModalRoute.of(context)?.settings.arguments as Map)["apartment"];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: SectionHeaderAndAppartementImages(apartment: apartment,),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 8,
                      right: 8,
                      left: 8,
                      bottom: rem(5.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitleAndPosition(apartment: apartment),
                        SectionAppartementFeature(apartment: apartment),
                        SectionLandLordProfile(apartment: apartment),
                        SectionDescription(apartment: apartment),
                        SectionAmentions(apartment: apartment),
                        SectionLocation(apartment: apartment),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: SectionRequestToBookAndPrice(apartment: apartment),
            ),
          ],
        ),
      ),
    );
  }
}
