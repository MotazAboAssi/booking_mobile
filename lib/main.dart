import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/navigation_observe.dart';
import 'package:booking/presentation/views/appartement_details_view.dart';
import 'package:booking/presentation/views/favorite_apartments_view.dart';
import 'package:booking/presentation/views/rate_your_stay_view.dart';
import 'package:booking/presentation/views/tenant_view.dart';
import 'package:booking/services/http_request.dart';
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
      },
      // initialRoute: favoriteApartments,
      home: Scaffold(
        body: FutureBuilder(
          future: HttpRequest().getMostPopularApartments(),
          builder: (context, asyncSnapshot) {
            return Column(
              children: [
                Center(
                  child: Text("data", style: TextStyle(fontSize: rem(10))),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
