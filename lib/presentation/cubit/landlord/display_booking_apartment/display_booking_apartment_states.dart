import 'package:booking/types/apartment_type.dart';

class DisplayBookingApartmentStates {
  final List<ApartmentType> apartments;
  final String? message;

  DisplayBookingApartmentStates({
    required this.apartments,
    required this.message,
  });
}

class DisplayBookingApartmentInitial extends DisplayBookingApartmentStates {
  DisplayBookingApartmentInitial({
    required super.apartments,
    required super.message,
  });
}

class DisplayBookingApartmentLoading extends DisplayBookingApartmentStates {
  DisplayBookingApartmentLoading({
    required super.apartments,
    required super.message,
  });
}

class DisplayBookingApartmentSuccessful extends DisplayBookingApartmentStates {
  DisplayBookingApartmentSuccessful({
    required super.apartments,
    required super.message,
  });
}

class DisplayBookingApartmentFaild extends DisplayBookingApartmentStates {
  DisplayBookingApartmentFaild({
    required super.apartments,
    required super.message,
  });
}
