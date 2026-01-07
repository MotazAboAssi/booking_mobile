import 'dart:developer';
import 'dart:io';

import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/determine_mode_by_index.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/details_request_view/details_request_view_cubit.dart';
import 'package:booking/presentation/cubit/favorite_apartment_view.dart/favorite_apartment_view_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/filter_view/filter_view_cubit.dart';
import 'package:booking/presentation/cubit/get_all_rate_your_stay/get_all_rate_your_stay_cubit.dart';
import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_cubit.dart';
import 'package:booking/presentation/cubit/my_booking_view/my_booking_view_cubit.dart';
import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_cubit.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_states.dart';
import 'package:booking/presentation/views/landlord/appartement_details_view_for_landlord.dart';
import 'package:booking/presentation/views/landlord/detail_request_view.dart';
import 'package:booking/presentation/views/landlord/dispaly_resault_category.dart';
import 'package:booking/presentation/views/profile_view_landlord.dart';
import 'package:booking/presentation/views/tenant/display_filter_view.dart';
import 'package:booking/presentation/views/tenant/filter_view.dart';
import 'package:booking/presentation/views/profile_view_tenant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_cubit.dart';
import 'package:booking/presentation/views/tenant/booking_confirme.dart';
import 'package:booking/presentation/views/auth/role_selection_view.dart';
import 'package:booking/presentation/views/tenant/my_booking_view.dart';
import 'package:booking/presentation/views/tenant/appartement_details_view_for_tenant.dart';
import 'package:booking/presentation/views/auth/login_view.dart';
import 'package:booking/presentation/views/auth/register_view.dart';
import 'package:booking/presentation/views/tenant/favorite_apartments_view.dart';
import 'package:booking/presentation/views/tenant/rate_your_stay_view.dart';
import 'package:booking/presentation/views/tenant/tenant_view.dart';
import 'package:booking/presentation/views/landlord/land_lord_add_apartment.dart';
import 'package:booking/presentation/views/landlord/land_lord_dashboard.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';

typedef VoidCallBackFile = void Function(File?);
typedef FileCallBackvoid = File? Function();
typedef BoolFunString = bool Function(String);

void main() async {
  runApp(
    BlocProvider(create: (context) => ToggleColorCubit(), child: const MyApp()),
  );
}

typedef StringFunVoid = String Function();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<ToggleColorCubit>(context);
    cubit.fromScratch();
  }

  @override
  Widget build(BuildContext context) {
    log(ThemeMode.values.toString());
    return BlocBuilder<ToggleColorCubit, ToggleColorStates>(
      builder: (context, state) {
        printWhite('${state.mode?.name}');
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.mode ?? ThemeMode.system,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [Observ()],
          routes: {
            tenantView: (context) => BlocProvider(
              create: (context) => TenantViewCubit(),
              child: TenantView(),
            ),
            appartementDetailsViewForTenant: (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>;
    
              return BlocProvider(
                create: (_) => GetAllRateYourStayCubit(),
                child: AppartementDetailsViewForTenant(
                  apartment: args["apartment"],
                ),
              );
            },
    
            rateYourStayView: (context) => BlocProvider(
              create: (BuildContext context) => RateYourStayCubit(),
              child: RateYourStayView(),
            ),
            favoriteApartments: (context) => BlocProvider(
              create: (context) => FavoriteApartmentViewCubit(),
              child: FavoriteApartments(),
            ),
            addApartment: (context) => BlocProvider(
              create: (context) => ApiApartmentCubit(),
              child: LandLordAddApartment(),
            ),
            landlordDashBoard: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DisplayBookingApartmentCubit>(
                  create: (_) => DisplayBookingApartmentCubit(),
                ),
                BlocProvider<FetchAllApartmentForLandlordCubit>(
                  create: (_) => FetchAllApartmentForLandlordCubit(),
                ),
              ],
              child: const LandLordDashboard(),
            ),
    
            mybooking: (context) => BlocProvider(
              create: (context) => MyBookingViewCubit(),
              child: MyBookingView(),
            ),
            loginView: (context) => BlocProvider(
              create: (_) => NavigateFromLoginCubit(),
              child: LoginView(),
            ),
            registerView: (context) => RegisterView(),
            bookingconfirme: (context) => BookingConfirme(),
            roleSelectionView: (context) => RoleSelectionView(),
            profileViewTenant: (context) => BlocProvider<FetchUserCubit>(
              create: (_) => FetchUserCubit(),
              child: ProfileViewTenant(),
            ),
            profileViewLandLord: (context) => BlocProvider<FetchUserCubit>(
              create: (_) => FetchUserCubit(),
              child: ProfileViewLandlord(),
            ),
            filterView: (_) => BlocProvider(
              create: (BuildContext context) => FilterViewCubit(),
              child: FilterView(),
            ),
            displayFilterView: (_) => DisplayFilterView(),
            dispalyResaultCategory: (_) => DispalyResaultCategory(),
            detailRequestView: (_) => BlocProvider(
              create: (context) => DetailsRequestViewCubit(),
              child: DetailRequestView(),
            ),
            appartementDetailsViewForLandlord: (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>;
    
              return BlocProvider(
                create: (_) => GetAllRateYourStayCubit(),
                child: AppartementDetailsViewForLandlord(
                  apartment: args["apartment"],
                ),
              );
            },
          },
          // home: SettingView(),
          initialRoute: loginView,
          // home: Scaffold(
          //   body: FutureBuilder(
          //     future: HttpRequest().getAllConfirmedBookingsLandlord(),
          //     builder: (context, snapshot) => ElevatedButton(
          //       onPressed: () async {
          //         // await AuthStorage().deleteAllData();
          //       },
          //       child: Center(child: Text("data")),
          //     ),
          //   ),
          // ),
        );
      },
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
