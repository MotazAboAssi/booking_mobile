import 'package:booking/presentation/cubit/my_booking_view/my_booking_view_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBookingViewCubit extends Cubit<MyBookingViewStates> {
  MyBookingViewCubit()
    : super(MyBookingViewInitial(bookings: [], message: null));
  Future<void> getAllApartmentsBooking(
 
  ) async {
    try {
      // emit(
      //   MyBookingViewInitial(bookings: state.bookings, message: state.message),
      // );
      // final List<BookingApartmentType> bookins = await HttpRequest()
      //     .getAllbookingApartments();
      emit(MyBookingViewSuccessful(bookings: [], message: state.message));
    } catch (e) {
      emit(MyBookingViewFaild(bookings: [], message: e.toString()));
    }
  }
}
