import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingApartmentCubit extends Cubit<BookingApartmentStates> {
  BookingApartmentCubit() : super(BookingApartmentInitial());
  Future<void> booking(
    int idApartment,
    DateTime startDate,
    DateTime endDate,
  ) async {
    emit(BookingApartmentLoading());
    try {
      Map<String, dynamic> response = await HttpRequest()
          .bookingParticularApartmentByID(idApartment, startDate, endDate);
      emit(BookingApartmentSuccessful(response: response));
    } catch (e) {
      emit(BookingApartmentFaild(errorMessage: e.toString()));
    }
  }
}
