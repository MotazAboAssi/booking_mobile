import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_cubit.dart';
import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:booking/types/rate_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionSubmitReviewAndSkip extends StatelessWidget {
  final BoxConstraints parent;
  const SectionSubmitReviewAndSkip({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final BookingApartmentType apartment =
            (ModalRoute.of(context)?.settings.arguments as Map)['house'];
        final cubit = BlocProvider.of<RateYourStayCubit>(context);
        // printGreen(cubit.state.pov.comment!);
        cubit.state.pov.rate = calculateRate(cubit.state.pov);
        cubit.addRate(apartment.apartmentID, cubit.state.pov);
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: fourthly,

        fixedSize: Size(parent.maxHeight * 0.9, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      child: BlocConsumer<RateYourStayCubit, RateYourStayStates>(
        builder: (context, state) {
          if (state is RateYourStayLoading) {
            return SizedBox(
              width: rem(1.5),
              height: rem(1.5),
              child: CircularProgressIndicator(backgroundColor: thirdly),
            );
          } else if (state is RateYourStaySuccessful) {
            return SizedBox(child: Icon(Icons.check, color: thirdly));
          }
          return Text(
            "Submit Review",
            style: TextStyle(
              color: thirdly,
              fontWeight: FontWeight.bold,
              fontSize: rem(1),
            ),
          );
        },
        listener: (context, state) async {
          if ((state is RateYourStaySuccessful)) {
            await Future.delayed(const Duration(seconds: 1));
            final BookingApartmentType apartment =
                (ModalRoute.of(context)?.settings.arguments as Map)['house'];

            final ApartmentType house = await HttpRequest().getApartmentByID(
              apartment.apartmentID,
            );
            printYallow(apartment.apartmentID.toString());
            Navigator.pushReplacementNamed(
              context,
              appartementDetailsViewForTenant,
              arguments: {'apartment': house},
            );
          } else if (state is RateYourStayFaild) {
            customSnakBar(
              margin: EdgeInsets.only(bottom: rem(4)),
              context: context,
              color: Colors.red,
              message: state.message!,
            );
          }
        },
      ),
    );
  }

  int calculateRate(RateType rate) {
    final int communication = rate.communication ?? 0;
    final int value = rate.value ?? 0;
    final int location = rate.location ?? 0;
    final int cleanLess = rate.cleanLess ?? 0;
    final int overallExperlence = rate.overallExperlence ?? 0;

    return ((((communication + value + location + cleanLess) / 4).floor() +
                overallExperlence) /
            2)
        .floor();
  }
}
