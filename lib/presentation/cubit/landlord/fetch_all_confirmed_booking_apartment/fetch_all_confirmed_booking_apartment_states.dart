import 'package:booking/types/booking_apartment_type.dart';

class FetchAllConfirmedBookingApartmentStates {
  final List<BookingApartmentType> apartments;
  final String? message;

  FetchAllConfirmedBookingApartmentStates({
    required this.apartments,
    required this.message,
  });
}

class FetchAllConfirmedBookingApartmentInitial
    extends FetchAllConfirmedBookingApartmentStates {
  FetchAllConfirmedBookingApartmentInitial({
    required super.apartments,
    required super.message,
  });
}

class FetchAllConfirmedBookingApartmentLoading
    extends FetchAllConfirmedBookingApartmentStates {
  FetchAllConfirmedBookingApartmentLoading({
    required super.apartments,
    required super.message,
  });
}

class FetchAllConfirmedBookingApartmentSucceful
    extends FetchAllConfirmedBookingApartmentStates {
  FetchAllConfirmedBookingApartmentSucceful({
    required super.apartments,
    required super.message,
  });
}

class FetchAllConfirmedBookingApartmentFaild
    extends FetchAllConfirmedBookingApartmentStates {
  FetchAllConfirmedBookingApartmentFaild({
    required super.apartments,
    required super.message,
  });
}
