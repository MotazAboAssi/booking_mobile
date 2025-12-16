import 'package:booking/data/models/auth/login/login_form.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/navigation_observe.dart';
import 'package:booking/presentation/views/My_Booking_view.dart';
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

      home: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.apartment, color: Colors.white, size: rem(6)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(rem(1)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(rem(1)),
                    topRight: Radius.circular(rem(1)),
                  ),
                ),
                child: ListView(
                  children: [
                    Text(
                      "Welcome To Back!",
                      style: TextStyle(
                        fontSize: rem(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: rem(1)),
                      child: Text(
                        "Log in to your phone number to continue.",
                        style: TextStyle(
                          fontSize: rem(1),
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isSecure = ValueNotifier<bool>(false);
    return ValueListenableBuilder(
      valueListenable: isSecure,
      builder: (context, value, child) {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rem(1)),
            side: BorderSide(
              color: Colors.black,
              width: 20,
              strokeAlign: 10,
              style: BorderStyle.solid,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              isSecure.value = !isSecure.value;
            },
            icon: Icon(
              isSecure.value
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
            ),
          ),
          title: TextFormField(
            obscureText: isSecure.value,
            obscuringCharacter: "*",
            validator: (value) {
              if (value == "" || value == null) {
                return "this field is required";
              } else if (!(value.replaceAll(RegExp(r"^\\+963\\d{9}$"), "") ==
                  value)) {
                return "Password not correct";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Passowrd",
              hintText: "********",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(rem(1)),
              ),
            ),
          ),
        );
      },
    );
  }
}
      // home: Scaffold(
      //   body: FutureBuilder(
      //     // future: HttpRequest().logout(),
      //     // future: HttpRequest().login(
      //     //   UserLoginType(phone: "10000000", password: "00000000"),
      //     // ),
      //     future: HttpRequest().bookingsApartmentByID(0),
      //     builder: (context, asyncSnapshot) {
      //       if (asyncSnapshot.hasData) {
      //         return Center(child: Text(asyncSnapshot.data?.city ?? "null"));
      //       } else {
      //         return Center(child: Text(asyncSnapshot.error.toString()));
      //       }
      //     },
      //   ),
      // ),
