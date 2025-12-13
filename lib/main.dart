import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';
import 'package:booking/presentation/views/appartement_details_view.dart';
import 'package:booking/presentation/views/favorite_apartments_view.dart';
import 'package:booking/presentation/views/rate_your_stay_view.dart';
import 'package:booking/presentation/views/tenant_view.dart';
import 'package:booking/presentation/views/Land_Lord_Add_Apartment.dart';
import 'package:booking/presentation/views/Land_Lord_Dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      },
      initialRoute: favoriteApartments,
    );
  }
}
