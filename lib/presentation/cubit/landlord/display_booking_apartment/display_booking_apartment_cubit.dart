import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayBookingApartmentCubit
    extends Cubit<DisplayBookingApartmentStates> {
  DisplayBookingApartmentCubit()
    : super(DisplayBookingApartmentInitial(apartments: [], message: null));
  Future<void> displayBookingApartment() async {
    try {
      emit(
        DisplayBookingApartmentLoading(
          apartments: state.apartments,
          message: state.message,
        ),
      );
      await HttpRequest().bookingsLandlord();
      emit(
        DisplayBookingApartmentSuccessful(
          apartments: state.apartments,
          message: state.message,
        ),
      );
    } catch (e) {
      emit(
        DisplayBookingApartmentFaild(
          apartments: state.apartments,
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }
}
