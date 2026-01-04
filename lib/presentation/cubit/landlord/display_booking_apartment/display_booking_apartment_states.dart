import 'package:booking/types/booking_apartment_type.dart';

class DisplayBookingApartmentStates {
  final List<BookingApartmentType> bookings;
  final String? message;

  DisplayBookingApartmentStates({
    required this.bookings,
    required this.message,
  });
}

class DisplayBookingApartmentInitial extends DisplayBookingApartmentStates {
  DisplayBookingApartmentInitial({
    required super.bookings,
    required super.message,
  });
}

class DisplayBookingApartmentLoading extends DisplayBookingApartmentStates {
  DisplayBookingApartmentLoading({
    required super.bookings,
    required super.message,
  });
}

class DisplayBookingApartmentSuccessful extends DisplayBookingApartmentStates {
  DisplayBookingApartmentSuccessful({
    required super.bookings,
    required super.message,
  });
}

class DisplayBookingApartmentFaild extends DisplayBookingApartmentStates {
  DisplayBookingApartmentFaild({
    required super.bookings,
    required super.message,
  });
}
