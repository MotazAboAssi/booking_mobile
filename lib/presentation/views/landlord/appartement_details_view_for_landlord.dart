import 'package:booking/data/models/rate_your_stay_view/model_rating_bar.dart';
import 'package:booking/data/sections/appartement_details_view/section_amentions.dart';
import 'package:booking/data/sections/appartement_details_view/section_appartement_feature.dart';
import 'package:booking/data/sections/appartement_details_view/section_description.dart';
import 'package:booking/data/sections/appartement_details_view/section_location.dart';
import 'package:booking/data/sections/appartement_details_view/section_title_and_position.dart';
import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/back_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/get_all_rate_your_stay/get_all_rate_your_stay_cubit.dart';
import 'package:booking/presentation/cubit/get_all_rate_your_stay/get_all_rate_your_stay_states.dart';
import 'package:booking/presentation/views/tenant/appartement_details_view_for_tenant.dart';
import 'package:booking/presentation/widgets/swiper_images.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppartementDetailsViewForLandlord extends StatefulWidget {
  const AppartementDetailsViewForLandlord({super.key, required this.apartment});
  final ApartmentType apartment;

  @override
  State<AppartementDetailsViewForLandlord> createState() =>
      _AppartementDetailsViewForLandlordState();
}

class _AppartementDetailsViewForLandlordState
    extends State<AppartementDetailsViewForLandlord> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<GetAllRateYourStayCubit>(context);
    cubit.getAllRateByID(widget.apartment.idApartment);
  }

  @override
  Widget build(BuildContext context) {
    printGreen(widget.apartment.idApartment.toString());

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
                      apartment: widget.apartment,
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
                        SectionTitleAndPosition(apartment: widget.apartment),
                        SectionAppartementFeature(apartment: widget.apartment),
                        SectionDescription(apartment: widget.apartment),
                        SectionAmentions(apartment: widget.apartment),
                        SectionLocation(apartment: widget.apartment),
                        Reviews(),
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
                child: SectionEditOrRemoveAndPrice(apartment: widget.apartment),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class SectionHeaderAndAppartementImages extends StatelessWidget {
  final ApartmentType? apartment;

  const SectionHeaderAndAppartementImages({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        apartment!.images!.isEmpty
            ? Container(
                decoration: apartment != null
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(anonymousManAvatar),
                        ),
                      )
                    : null,
              )
            : SwiperImage(images: apartment?.images),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: context.appTheme.primarye.withAlpha(127),
            child: IconButton(
              onPressed: () {
                backTo(context);
              },
              icon: Icon(Icons.arrow_back, color: context.appTheme.thirdly),
            ),
          ),
        ),
      ],
    );
  }
}

class SectionEditOrRemoveAndPrice extends StatelessWidget {
  final ApartmentType apartment;

  const SectionEditOrRemoveAndPrice({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.appTheme.thirdly,
        boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: 5)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "${apartment.priceForMonth}\$",
                style: TextStyle(
                  fontSize: rem(1.5),
                  fontWeight: FontWeight.bold,
                  color: context.appTheme.fourthly,
                ),
              ),
              Text(" /month"),
            ],
          ),
          Row(
            spacing: rem(1),
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: context.appTheme.success),
                onPressed: () {
                  ApartmentType apartmentCopy = ApartmentType.copyFrom(
                    apartment,
                  );
                  Navigator.pushNamed(
                    context,
                    addApartment,
                    arguments: {'apartment': apartmentCopy},
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: context.appTheme.error),
                onPressed: () async {
                  await HttpRequest().deleteApartmentForLandlord(
                    apartment.idApartment,
                  );
                  // final fetchAllApartmentForLandlord =
                  //     BlocProvider.of<FetchAllApartmentForLandlordCubit>(
                  //       context,
                  //     );
                  // fetchAllApartmentForLandlord.fetchAllApartmentForLandlord();
                  // navigateTo(context, landlordDashBoard);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    landlordDashBoard,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
