import 'dart:io';
import 'package:booking/presentation/cubit/favorite_apartment_view.dart/favorite_apartment_view_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_states.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:booking/presentation/views/profile_view.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_cubit.dart';
import 'package:booking/presentation/views/booking_confirme.dart';
import 'package:booking/presentation/views/auth/role_selection_view.dart';
import 'package:booking/presentation/views/my_booking_view.dart';
import 'package:booking/presentation/views/appartement_details_view.dart';
import 'package:booking/presentation/views/auth/login_view.dart';
import 'package:booking/presentation/views/auth/register_view.dart';
import 'package:booking/presentation/views/favorite_apartments_view.dart';
import 'package:booking/presentation/views/rate_your_stay_view.dart';
import 'package:booking/presentation/views/tenant_view.dart';
import 'package:booking/presentation/views/land_lord_add_apartment.dart';
import 'package:booking/presentation/views/land_lord_dashboard.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';

typedef VoidCallBackFile = void Function(File?);
typedef FileCallBackvoid = File? Function();
typedef BoolFunString = bool Function(String);

void main() {
  runApp(const MyApp());
}

typedef StringFunVoid = String Function();

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
        tenantView: (context) => BlocProvider(
          create: (BuildContext context) => TenantViewCubit(),
          child: TenantView(),
        ),
        appartementDetailsView: (context) => AppartementDetailsView(),
        rateYourStayView: (context) => RateYourStayView(),
        favoriteApartments: (context) => BlocProvider(
          create: (context) => FavoriteApartmentViewCubit(),
          child: FavoriteApartments(),
        ),
        addApartment: (context) => LandLordAddApartment(),
        landlordDashBoard: (context) => LandLordDashboard(),
        mybooking: (context) => MyBookingView(),
        loginView: (context) => BlocProvider(
          create: (_) => NavigateFromLoginCubit(),
          child: LoginView(),
        ),
        registerView: (context) => RegisterView(),
        bookingconfirme: (context) => BookingConfirme(),
        roleSelectionView: (context) => RoleSelectionView(),
        profileView: (context) => BlocProvider<FetchUserCubit>(
          create: (_) => FetchUserCubit(),
          child: ProfileView(),
        ),
      },
      // home: SettingView(),
      initialRoute: loginView,
      // home: Scaffold(
      //   body: FutureBuilder(
      //     future: HttpRequest().increaseUserBalanceByID(2, 1000),
      //     builder: (context, snapshot) => ElevatedButton(
      //       onPressed: () async {
      //         await AuthStorage().deleteAllData();
      //       },
      //       child: Center(child: Text("data")),
      //     ),
      //   ),
      // ),
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
