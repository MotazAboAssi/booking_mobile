import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingApartmentCubit extends Cubit<BookingApartmentStates> {
  BookingApartmentCubit() : super(BookingApartmentInitial());
  Future<void> update(
    int idApartment,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      emit(BookingApartmentLoading());
      await HttpRequest().updateBookingParticularApartmentByID(
        idApartment,
        startDate,
        endDate,
      );

      emit(BookingApartmentSuccessful(response: 'Done Update'));
    } catch (e) {
      emit(
        BookingApartmentFaild(
          errorMessage: e
              .toString()
              .replaceAll("Exception:", "")
              .replaceAll("Error: ", ""),
        ),
      );
    }
  }

  Future<void> booking(
    int idApartment,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      emit(BookingApartmentLoading());
      Map<String, dynamic> response = await HttpRequest()
          .bookingParticularApartmentByID(idApartment, startDate, endDate);

      emit(BookingApartmentSuccessful(response: response['data']));
    } catch (e) {
      emit(
        BookingApartmentFaild(
          errorMessage: e
              .toString()
              .replaceAll("Exception:", "")
              .replaceAll("Error: ", ""),
        ),
      );
    }
  }
}
