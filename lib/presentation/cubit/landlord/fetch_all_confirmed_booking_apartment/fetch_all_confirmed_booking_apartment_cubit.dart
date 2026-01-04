import 'package:booking/presentation/cubit/landlord/fetch_all_confirmed_booking_apartment/fetch_all_confirmed_booking_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllConfirmedBookingApartmentCubit
    extends Cubit<FetchAllConfirmedBookingApartmentStates> {
  FetchAllConfirmedBookingApartmentCubit()
    : super(
        FetchAllConfirmedBookingApartmentInitial(apartments: [], message: null),
      );
  Future<void> getAllConfirmedBookingApartments() async {
    try {
      emit(
        FetchAllConfirmedBookingApartmentLoading(
          apartments: state.apartments,
          message: state.message,
        ),
      );
      final List<BookingApartmentType> confirmedBookingApartment =
          await HttpRequest().getAllConfirmedBookingsLandlord();
      emit(
        FetchAllConfirmedBookingApartmentSucceful(
          apartments: confirmedBookingApartment,
          message: state.message,
        ),
      );
    } catch (e) {
      emit(
        FetchAllConfirmedBookingApartmentFaild(
          apartments: state.apartments,
          message: e.toString(),
        ),
      );
    }
  }
}
