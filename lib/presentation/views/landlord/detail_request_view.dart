import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/data/sections/appartement_details_view/section_amentions.dart';
import 'package:booking/data/sections/appartement_details_view/section_appartement_feature.dart';
import 'package:booking/data/sections/appartement_details_view/section_description.dart';
import 'package:booking/data/sections/appartement_details_view/section_location.dart';
import 'package:booking/data/sections/appartement_details_view/section_title_and_position.dart';
import 'package:booking/data/sections/display_profile_user_view/section_group_of_input_field.dart';
import 'package:booking/data/sections/display_profile_user_view/section_image_picker_profile.dart';
import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/back_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/details_request_view/details_request_view_cubit.dart';
import 'package:booking/presentation/cubit/details_request_view/details_request_view_states.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/landlord/confirm_book/confirm_book_cubit.dart';
import 'package:booking/presentation/cubit/landlord/confirm_book/confirm_book_states.dart';
import 'package:booking/presentation/widgets/swiper_images.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailRequestView extends StatefulWidget {
  const DetailRequestView({super.key});

  @override
  State<DetailRequestView> createState() => _DetailRequestViewState();
}

class _DetailRequestViewState extends State<DetailRequestView> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<DetailsRequestViewCubit>(context);
    cubit.fetch(4, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<DetailsRequestViewCubit, DetailsRequestViewStates>(
          builder: (context, state) {
            if (state is DetailsRequestViewSuccessful) {
              return BodyDetailRequestView(
                apatrment: state.apartment,
                user: state.user,
              );
            } else if (state is DetailsRequestViewFaild) {
              return Center(
                child: Text(
                  state.message ?? "",
                  style: TextStyle(
                    fontSize: rem(1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return Skeletonizer(child: BodyDetailRequestView());
            }
          },
        ),
      ),
    );
  }
}

class BodyDetailRequestView extends StatelessWidget {
  const BodyDetailRequestView({super.key, this.apatrment, this.user});
  final ApartmentType? apatrment;
  final UserRegisterType? user;

  @override
  Widget build(BuildContext context) {
    BookingApartmentType book = BookingApartmentType.empty();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      book = (ModalRoute.of(context)?.settings.arguments as Map)['book'];
    }
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Apartment',
                style: TextStyle(
                  fontSize: rem(1.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: SectionHeaderAndAppartementImages(apartment: apatrment),
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
                    SectionTitleAndPosition(
                      apartment: apatrment ?? ApartmentType.empty(),
                    ),
                    SectionAppartementFeature(
                      apartment: apatrment ?? ApartmentType.empty(),
                    ),

                    SectionDescription(
                      apartment: apatrment ?? ApartmentType.empty(),
                    ),
                    SectionAmentions(
                      apartment: apatrment ?? ApartmentType.empty(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price For Month :",
                          style: TextStyle(
                            fontSize: rem(1.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${apatrment?.priceForMonth}\$",
                              style: TextStyle(
                                fontSize: rem(2),
                                fontWeight: FontWeight.bold,
                                color: context.appTheme.fourthly,
                              ),
                            ),
                            Text(" /month"),
                          ],
                        ),
                      ],
                    ),
                    SectionLocation(
                      apartment: apatrment ?? ApartmentType.empty(),
                    ),
                    BlocProvider(
                      create: (BuildContext context) => FetchUserCubit(),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(rem(2)),
                          child: Column(
                            children: [
                              Text(
                                'Tenant',
                                style: TextStyle(
                                  fontSize: rem(1.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: rem(1)),
                                child: SectionImagePickerProfile(
                                  image: user?.profileImage,
                                ),
                              ),
                              SectionGroupOfInputField(user: user),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Request',
                            style: TextStyle(
                              fontSize: rem(1.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Stay : ${book.startDate.toIso8601String().split('T')[0]} - ${book.endDate.toIso8601String().split('T')[0]}',
                            style: TextStyle(
                              fontSize: rem(1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'total Cost : ${book.totalCost} \$',
                            style: TextStyle(
                              fontSize: rem(1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        book.status != BookingStatus.pending
            ? Container()
            : BlocProvider(
                create: (context) => ConfirmBookCubit(),
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: SectionAcceptAndRejectedRequest(
                    apartment: apatrment ?? ApartmentType.empty(),
                  ),
                ),
              ),
      ],
    );
  }
}

class SectionAcceptAndRejectedRequest extends StatelessWidget {
  final ApartmentType apartment;

  const SectionAcceptAndRejectedRequest({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<ConfirmBookCubit, ConfirmBookStates>(
          builder: (context, state) {
            final bool isLoading = state is ConfirmBookLoading;
            bool isAccept = false;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: context.appTheme.thirdly,
                boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: 5)],
              ),
              child: Row(
                spacing: rem(0.5),
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appTheme.success,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(rem(1)),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              isAccept = true;
                              final cubit = BlocProvider.of<ConfirmBookCubit>(
                                context,
                              );
                              final BookingApartmentType book =
                                  await (ModalRoute.of(
                                        context,
                                      )?.settings.arguments
                                      as Map)['book'];
                              await cubit.confirm(book.bookingID, true);
                              await Navigator.of(
                                context,
                              ).pushNamedAndRemoveUntil(
                                landlordDashBoard,
                                (Route<dynamic> route) => false,
                              );
                            },
                      child: (isLoading && isAccept)
                          ? SizedBox(
                              width: rem(1),
                              height: rem(1),
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Accept',
                              style: TextStyle(
                                color: context.appTheme.thirdly,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.appTheme.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(rem(1)),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              final cubit = BlocProvider.of<ConfirmBookCubit>(
                                context,
                              );
                              final BookingApartmentType book =
                                  await (ModalRoute.of(
                                        context,
                                      )?.settings.arguments
                                      as Map)['book'];
                              await cubit.confirm(book.bookingID, false);
                              await Navigator.of(
                                context,
                              ).pushNamedAndRemoveUntil(
                                landlordDashBoard,
                                (Route<dynamic> route) => false,
                              );
                            },
                      child: (isLoading && !isAccept)
                          ? SizedBox(
                              width: rem(1),
                              height: rem(1),
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Rejected',
                              style: TextStyle(
                                color: context.appTheme.thirdly,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (BuildContext context, ConfirmBookStates state) {
            if (state is ConfirmBookFaild) {
              return customSnakBar(
                margin: EdgeInsets.only(bottom: rem(4)),
                context: context,
                color: context.appTheme.error,
                message: '${state.message}',
              );
            } else if (state is ConfirmBookSuccessful) {
              return customSnakBar(
                margin: EdgeInsets.only(bottom: rem(4)),
                context: context,
                color: context.appTheme.error,
                message: '${state.message}',
              );
            }
          },
        );
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
        apartment == null
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(anonymousManAvatar)),
                ),
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
