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

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllRateYourStayCubit, GetAllRateYourStayStates>(
      builder: (context, state) {
        if (state is GetAllRateYourStaySuccessful) {
          return state.rates.isEmpty
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: rem(1.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: ListView.builder(
                        itemCount: state.rates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: rem(1)),
                            padding: EdgeInsets.all(rem(1)),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reviewed on ${state.rates[index].createdAt.toIso8601String().split("T")[0]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: rem(1.1),
                                  ),
                                ),
                                state.rates[index].rate == null
                                    ? Container()
                                    : ModelRatingBar(
                                        itemSize: rem(1.5),
                                        initialRating: double.parse(
                                          state.rates[index].rate.toString(),
                                        ),
                                        ignoreGestures: true,
                                      ),
                                state.rates[index].comment == null
                                    ? Container()
                                    : Text(
                                        state.rates[index].comment!,
                                        style: TextStyle(fontSize: rem(1)),
                                      ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        } else {
          printGreen((state is GetAllRateYourStayFaild).toString());
          return Skeletonizer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Reviews",
                    style: TextStyle(
                      fontSize: rem(1.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(rem(1)),
                  decoration: BoxDecoration(
                    color: context.appTheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reviewed on 12-12-12",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: rem(1.1),
                        ),
                      ),
                      ModelRatingBar(
                        itemSize: rem(1.5),
                        initialRating: 4,
                        ignoreGestures: true,
                      ),
                      Text(
                        'sldkfj;ksldjf;skdfj;sskdf;lskfj;dkljf;skjdf;sdkjf;skdfj;sdklf;s',
                        style: TextStyle(fontSize: rem(1)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
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
            backgroundColor: context.appTheme.primary.withAlpha(127),
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
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    addApartment,
                    arguments: {'apartment': apartment},
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
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
