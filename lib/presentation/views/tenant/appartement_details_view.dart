import 'package:booking/data/sections/appartement_details_view/section_amentions.dart';
import 'package:booking/data/sections/appartement_details_view/section_appartement_feature.dart';
import 'package:booking/data/sections/appartement_details_view/section_description.dart';
import 'package:booking/data/sections/appartement_details_view/section_header_and_appartement_images.dart';
import 'package:booking/data/sections/appartement_details_view/section_land_lord_profile.dart';
import 'package:booking/data/sections/appartement_details_view/section_location.dart';
import 'package:booking/data/sections/appartement_details_view/section_request_to_book_and_price.dart';
import 'package:booking/data/sections/appartement_details_view/section_title_and_position.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppartementDetailsView extends StatelessWidget {
  const AppartementDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ApartmentType apartment =
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
                    child: SectionHeaderAndAppartementImages(
                      apartment: apartment,
                    ),
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
                        BlocProvider(
                          create: (BuildContext context) => FetchUserCubit(),
                          child: SectionLandLordProfile(apartment: apartment),
                        ),
                        SectionDescription(apartment: apartment),
                        SectionAmentions(apartment: apartment),
                        SectionLocation(apartment: apartment),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "Review",
                                style: TextStyle(
                                  fontSize: rem(1.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            AspectRatio(
                              aspectRatio: 6 / 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondary.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Not Available Location",
                                      style: TextStyle(fontSize: rem(2)),
                                    ),
                                    Text(
                                      "😢",
                                      style: TextStyle(fontSize: rem(2)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BlocProvider(
              create: (BuildContext context) => BookingApartmentCubit(),
              child: Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: SectionRequestToBookAndPrice(apartment: apartment),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



