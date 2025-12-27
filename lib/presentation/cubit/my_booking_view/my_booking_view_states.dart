import 'package:booking/types/booking_apartment_type.dart';

class MyBookingViewStates {
  final List<BookingApartmentType> bookings;
  final String? message;

  MyBookingViewStates({required this.bookings, required this.message});
}

class MyBookingViewInitial extends MyBookingViewStates {
  MyBookingViewInitial({required super.bookings, required super.message});
}

class MyBookingViewLoading extends MyBookingViewStates {
  MyBookingViewLoading({required super.bookings, required super.message});
}

class MyBookingViewSuccessful extends MyBookingViewStates {
  MyBookingViewSuccessful({required super.bookings, required super.message});
}

class MyBookingViewFaild extends MyBookingViewStates {
  MyBookingViewFaild({required super.bookings, required super.message});
}
