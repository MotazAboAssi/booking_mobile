import 'dart:io';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';
import 'package:booking/presentation/views/booking_confirme.dart';
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
        bookingconfirme: (context) => BookingConfirme(),
      },
      initialRoute: bookingconfirme,
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
