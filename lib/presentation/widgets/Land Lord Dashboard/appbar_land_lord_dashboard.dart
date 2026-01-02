// import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_cubit.dart';
import 'package:flutter/material.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar appbarLandLordDashboard(BuildContext context) {
  return AppBar(
    forceMaterialTransparency: true,
    title: Text("Dashboard", style: TextStyle(fontSize: rem(1))),
    centerTitle: true,
    leading: Tooltip(
      message: 'new apartment',
      child: IconButton(
        onPressed: () => Navigator.pushNamed(context, addApartment),
        icon: Icon(Icons.add),
      ),
    ),
    actions: [
      Tooltip(
        message: 'refresh new requests',
        child: IconButton(
          onPressed: ()  {
            final displayBookingApartment =
                BlocProvider.of<DisplayBookingApartmentCubit>(context);
            displayBookingApartment.displayBookingApartment();
            final fetchAllApartmentForLandlord =
                BlocProvider.of<FetchAllApartmentForLandlordCubit>(context);
            fetchAllApartmentForLandlord.fetchAllApartmentForLandlord();
          },
          icon: Icon(Icons.refresh),
        ),
      ),
    ],
  );
}
