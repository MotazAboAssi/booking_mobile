import 'package:booking/presentation/cubit/get_all_notifications/get_all_notifications_cubit.dart';
import 'package:booking/presentation/views/waiting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/presentation/cubit/get_all_rate_your_stay/get_all_rate_your_stay_cubit.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:booking/presentation/cubit/details_request_view/details_request_view_cubit.dart';
import 'package:booking/presentation/cubit/favorite_apartment_view.dart/favorite_apartment_view_cubit.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_cubit.dart';
import 'package:booking/presentation/cubit/filter_view/filter_view_cubit.dart';
import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_cubit.dart';
import 'package:booking/presentation/cubit/my_booking_view/my_booking_view_cubit.dart';
import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_cubit.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_cubit.dart';

import 'package:booking/presentation/views/landlord/appartement_details_view_for_landlord.dart';
import 'package:booking/presentation/views/landlord/detail_request_view.dart';
import 'package:booking/presentation/views/landlord/dispaly_resault_category.dart';
import 'package:booking/presentation/views/landlord/profile_view_landlord.dart';
import 'package:booking/presentation/views/landlord/land_lord_add_apartment.dart';
import 'package:booking/presentation/views/landlord/land_lord_dashboard.dart';
import 'package:booking/presentation/views/tenant/profile_view_tenant.dart';
import 'package:booking/presentation/views/tenant/appartement_details_view_for_tenant.dart';
import 'package:booking/presentation/views/tenant/display_filter_view.dart';
import 'package:booking/presentation/views/tenant/filter_view.dart';
import 'package:booking/presentation/views/tenant/tenant_view.dart';
import 'package:booking/presentation/views/tenant/booking_confirme.dart';
import 'package:booking/presentation/views/tenant/my_booking_view.dart';
import 'package:booking/presentation/views/tenant/favorite_apartments_view.dart';
import 'package:booking/presentation/views/tenant/rate_your_stay_view.dart';
import 'package:booking/presentation/views/auth/role_selection_view.dart';
import 'package:booking/presentation/views/auth/login_view.dart';
import 'package:booking/presentation/views/auth/register_view.dart';

const String tenantView = "TenantView";
const String appartementDetailsViewForTenant =
    "AppartementDetailsViewForTenant";
const String appartementDetailsViewForLandlord =
    "AppartementDetailsViewForLandlord";
const String rateYourStayView = "RateYourStayView";
const String favoriteApartments = "FavoriteApartments";
const String loginView = "LoginView";
const String registerView = "RegisterView";
const String roleSelectionView = "RoleSelectionView";
const String addApartment = "LandLordAddApartment";
const String landlordDashBoard = "LandLordDashboard";
const String mybooking = "MyBookingView";
const String bookingconfirme = "BookingConfirme";
const String profileViewTenant = "ProfileView";
const String profileViewLandLord = "ProfileViewLandlord";
const String filterView = "FilterView";
const String displayFilterView = "DisplayFilterView";
const String dispalyResaultCategory = "DispalyResaultCategory";
const String detailRequestView = "DetailRequestView";
const String waitingView = "WaitingView";

final Map<String, WidgetBuilder> appRoutes = {
  tenantView: (context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => TenantViewCubit()),
      BlocProvider(create: (context) => GetAllNotificationsCubit()),
    ],
    child: TenantView(),
  ),
  appartementDetailsViewForTenant: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocProvider(
      create: (_) => GetAllRateYourStayCubit(),
      child: AppartementDetailsViewForTenant(apartment: args["apartment"]),
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
  loginView: (context) =>
      BlocProvider(create: (_) => NavigateFromLoginCubit(), child: LoginView()),
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
  detailRequestView: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocProvider(
      create: (context) => DetailsRequestViewCubit(),
      child: DetailRequestView(book: args['book']),
    );
  },
  appartementDetailsViewForLandlord: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocProvider(
      create: (_) => GetAllRateYourStayCubit(),
      child: AppartementDetailsViewForLandlord(apartment: args["apartment"]),
    );
  },
  waitingView: (_) => BlocProvider(
    create: (context) => NavigateFromLoginCubit(),
    child: WaitingView(),
  ),
};
