import 'dart:io';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/back_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/methods/to_capitalize.dart';
import 'package:booking/helper/test/navigation_observe.dart';
import 'package:booking/presentation/views/my_booking_view.dart';
import 'package:booking/presentation/views/appartement_details_view.dart';
import 'package:booking/presentation/views/auth/login_view.dart';
import 'package:booking/presentation/views/auth/register_view.dart';
import 'package:booking/presentation/views/favorite_apartments_view.dart';
import 'package:booking/presentation/views/rate_your_stay_view.dart';
import 'package:booking/presentation/views/tenant_view.dart';
import 'package:booking/presentation/views/land_lord_add_apartment.dart';
import 'package:booking/presentation/views/land_lord_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef VoidCallBackFile = void Function(File?);
typedef FileCallBackvoid = File? Function();
typedef BoolFunString = bool Function(String);

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
        addApartment: (context) => LandLordAddApartment(),
        landlordDashBoard: (context) => LandLordDashboard(),
        mybooking: (context) => MyBookingView(),
        loginView: (context) => LoginView(),
        registerView: (context) => RegisterView(),
      },
      initialRoute: loginView,
      // home: RoleSelection(),
    );
  }
}

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: rem(1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: rem(1),
                  children: [
                    Column(
                      children: [
                        Icon(Icons.apartment, size: rem(4), color: fourthly),
                        Text(
                          toCapitalize("find your next home"),
                          style: TextStyle(
                            fontSize: rem(2),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "How will you be using the app ?",
                          style: TextStyle(color: fourthly),
                        ),
                      ],
                    ),

                    Column(
                      spacing: rem(1.5),
                      children: [
                        RoleCardModel(
                          icon: Icons.key,
                          role: 'tenant',
                          permissions: 'Search, tour and rent apartments',
                        ),
                        RoleCardModel(
                          icon: Icons.real_estate_agent,
                          role: 'landlord',
                          permissions: 'List and manage your properities',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),
                  TextButton(
                    onPressed: () {
                      backTo(context);
                    },
                    child: Text("Log in"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleCardModel extends StatelessWidget {
  final IconData icon;
  final String role;
  final String permissions;

  const RoleCardModel({
    super.key,
    required this.icon,
    required this.role,
    required this.permissions,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, registerView, arguments: {"role": role});
      },
      borderRadius: BorderRadius.circular(rem(1.4)),
      child: Container(
        padding: EdgeInsets.all(rem(1.5)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(rem(1.4)),
          border: Border.all(color: fourthly),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: rem(2), color: fourthly),
            Text(
              "I'm a ${toCapitalize(role)}",
              style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
            ),
            Text(
              permissions,
              style: TextStyle(fontSize: rem(1), color: fourthly.shade200),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({super.key});

  @override
  State<ImagePickerExample> createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null
              ? Image.network(_image!.path, height: 200)
              : const Text('No image selected'),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: pickImageFromGallery,
            child: const Text('Pick from Gallery'),
          ),

          ElevatedButton(
            onPressed: pickImageFromCamera,
            child: const Text('Pick from Camera'),
          ),
        ],
      ),
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
