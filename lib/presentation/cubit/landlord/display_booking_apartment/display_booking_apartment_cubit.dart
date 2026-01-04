
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayBookingApartmentCubit
    extends Cubit<DisplayBookingApartmentStates> {
  DisplayBookingApartmentCubit()
    : super(DisplayBookingApartmentInitial(bookings: [], message: null));
  Future<void> displayBookingApartment() async {
    try {
      emit(
        DisplayBookingApartmentLoading(
          bookings: state.bookings,
          message: state.message,
        ),
      );
      List<BookingApartmentType> bookings = await HttpRequest()
          .bookingsLandlord();
      emit(
        DisplayBookingApartmentSuccessful(
          bookings: bookings,
          message: state.message,
        ),
      );
    } catch (e) {
      emit(
        DisplayBookingApartmentFaild(
          bookings: state.bookings,
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }
}
