import 'package:booking/data/sections/Add_Appartment/section_select_photo.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';
import 'package:booking/presentation/views/My_Booking_view.dart';
import 'package:booking/presentation/views/appartement_details_view.dart';
import 'package:booking/presentation/views/favorite_apartments_view.dart';
import 'package:booking/presentation/views/rate_your_stay_view.dart';
import 'package:booking/presentation/views/tenant_view.dart';
import 'package:booking/presentation/views/Land_Lord_Add_Apartment.dart';
import 'package:booking/presentation/views/Land_Lord_Dashboard.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/user_login_type.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // printYallow(DateTime.parse("2005-11-13").toIso8601String().split('T')[0]);
    return MaterialApp(
      /*
      // dark mode and light mode setting
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        )
      themeMode: ThemeMode.light,
      */
      debugShowCheckedModeBanner: false,
      navigatorObservers: [Observ()],
      routes: {
        tenantView: (context) => TenantView(),
        appartementDetailsView: (context) => AppartementDetailsView(),
        rateYourStayView: (context) => RateYourStayView(),
        favoriteApartments: (context) => FavoriteApartments(),
        AddApartment: (context) => LandLordAddApartment(),
        dashboard: (context) => LandLordDashboard(),
        mybooking: (context) => MyBookingView(),
      },
      home: Scaffold(
        body: FutureBuilder(
          // future: HttpRequest().logout(),
          // future: HttpRequest().login(
          //   UserLoginType(phone: "10000000", password: "00000000"),
          // ),
          future: HttpRequest().bookingsApartmentByID(0),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return Center(child: Text(asyncSnapshot.data?.city ?? "null"));
            } else {
              return Center(child: Text(asyncSnapshot.error.toString()));
            }
          },
        ),
      ),
    );
  }
}
